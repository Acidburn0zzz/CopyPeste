/*--------------------------------------------------------------------*/
/*		     Epitech EIP 2017 groupe Copypeste		      */
/*								      */
/*			    Algo Rsync				      */
/*								      */
/* @by :	Guillaume Krier					      */
/* @created :	19/09/2015					      */
/* @update :	29/02/2015					      */
/*--------------------------------------------------------------------*/

/* INCLUDES */
#include "rsync.h"

#include <string.h>

#include <openssl/md5.h>

/* DEFINES */
#define MAX_MD5_LEN MD5_DIGEST_LENGTH

/*
** This function returns the result between 
** two string file with hash MD5 blocks
**
** @param: str_file1 - The string of the first file.
** @param: str_file2 - The string of the first file.
** @param: size_rd - The reading size in string.
** @return: Integer - Its return the result of Checksum compared.
*/
static int	compare_blocks(char *str_file1, char *str_file2, size_t size_rd)
{
  unsigned int	len1, len2;
  unsigned int	cpt1 = 0, cpt2 = 0;
  MD5_CTX	ctx1, ctx2;

  MD5_Init(&ctx1);
  MD5_Init(&ctx2);

  len1 = strlen(str_file1);
  len2 = strlen(str_file2);

  while (len1 > cpt1 || len2 > cpt2)
    {
      MD5_Update(&ctx1, str_file1 + cpt1, ((cpt1 + size_rd) > len1 ? len1 - cpt1: size_rd));
      MD5_Update(&ctx2, str_file2 + cpt2, ((cpt2 + size_rd) > len2 ? len2 - cpt2: size_rd));
      if (memcmp(&ctx1.data[0], &ctx2.data[0], MAX_MD5_LEN) != 0
	  || memcmp(&ctx1.data[1], &ctx2.data[1], MAX_MD5_LEN) != 0
	  || memcmp(&ctx1.data[2], &ctx2.data[2], MAX_MD5_LEN) != 0
	  || memcmp(&ctx1.data[3], &ctx2.data[3], MAX_MD5_LEN) != 0)
	return -1;
      cpt1 += size_rd;
      cpt2 += size_rd;
    }
  return 0;
}

/*
** This function is used to compare two files and find
** whether the sum of its characters are equal.
**
** @param: path1 - The string of the first file.
** @param: path2 - The string of the second file.
** @return: Integer - Its return the result of Diff compared.
*/
int	rsync(char *str_file1, char *str_file2, size_t size_rd)
{
  int	ret;

  if (!str_file1 || !str_file2 || !(size_rd > 0))
    return -1;
  if (strlen(str_file1) != strlen(str_file2))
    return -1;
  ret = compare_blocks(str_file1, str_file2, size_rd);
  return ret;
}

/*
** This function returns the result between
** two string file with its bytes
**
** @param: str_file1 - The string of the first file.
** @param: str_file2 - The string of the first file.
** @return: Integer - Its return the result of char compared.
*/
static int comfirm_checksum(char *str_file1, char *str_file2)
{
  char *tmp_file1, *tmp_file2;

  tmp_file1 = str_file1;
  tmp_file2 = str_file2;

  while (*tmp_file1 && *tmp_file2)
    {
      if (*tmp_file1 != *tmp_file2)
	return -1;
      ++tmp_file1;
      ++tmp_file2;
    }
  return 0;
}

/*
** This function returns the result between
** two string file with hash MD5 blocks
**
** @param: str_file1 - The string of the first file.
** @param: str_file2 - The string of the first file.
** @param: size_rd - The reading size in string.
** @return: Integer - Its return the result of Checksum compared.
*/
static int	compare_checksums(char *str_file1, char *str_file2, size_t size_rd)
{
  unsigned int	len1, len2;
  unsigned int	cpt1 = 0, cpt2 = 0;
  MD5_CTX	ctx1, ctx2;
  unsigned char	digest1[MAX_MD5_LEN], digest2[MAX_MD5_LEN];

  MD5_Init(&ctx1);
  MD5_Init(&ctx2);

  len1 = strlen(str_file1);
  len2 = strlen(str_file2);

  while (len1 > cpt1 && len2 > cpt2)
    {
      MD5_Update(&ctx1, str_file1 + cpt1, size_rd);
      MD5_Update(&ctx2, str_file1 + cpt2, size_rd);
      cpt1 += size_rd;
      cpt2 += size_rd;
    }
  MD5_Final(digest1, &ctx1);
  MD5_Final(digest2, &ctx2);
  if (memcmp(digest1, digest2, MAX_MD5_LEN) == 0)
    return comfirm_checksum(str_file1, str_file2);
  return -1;
}

/*
** This function is used to compare two files and find
** whether the checksum of its characters are equal.
**
** @param: path1 - The string of the first file.
** @param: path2 - The string of the second file.
** @return: Integer - Its return the result of Diff compared.
*/
int	rsync_checksum(char *str_file1, char *str_file2, size_t size_rd)
{
  int	ret;

  if (!str_file1 || !str_file2 || !(size_rd > 0)) 
    return -1;
  if (strlen(str_file1) != strlen(str_file2))
    return -1;
  ret = compare_checksums(str_file1, str_file2, size_rd);
  return ret;
}

