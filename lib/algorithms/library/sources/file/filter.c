
/* INCLUDES */
#include "filter.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/*
** Removes characters between Begin and End included
**
** @param: char *str - string
** @param: char *beg - first element
** @param: char *end - last element
** @return: Char* - return Char* param
*/
char	*filter_str(char *str, char *beg, char *end)
{
  int save = -1;
  char *tmp1 = str;
  char *tmp2 = str;

  while (*tmp2)
    {
      *tmp1 = *tmp2++;
      if (strncmp(tmp1, beg, strlen(beg)) == 0
	  && save == -1)
	save = 0;
      else if (strncmp(tmp1, end, strlen(end)) == 0
	       && save != -1)
	save = -1;
      else if (save == -1)
	  ++tmp1;
    }
  *tmp1 = 0;
  return str;
}

/*
** This function remove all spaces
** in the string
**
** @param: char *str - string
** @return: Char* - return Char* param
*/
char	*filter_all_space(char *str)
{
  char *tmp1 = str;
  char *tmp2 = str;

  while (*tmp2)
    {
      *tmp1 = *tmp2++;
      if (*tmp1 != ' ' && *tmp1 != '\t')
	++tmp1;
    }
  *tmp1 = 0;
  return str;
}

/*
** Removes all spaces in the string
**
** @param: char *str - string
** @return: Char* - return Char* param
*/
char	*filter_space(char *str)
{
  /*
  char *tmp1 = str;
  char *tmp2 = str;

  while (*tmp2)
    {
      if ((*tmp2 == ' ' || *tmp2 == '\t')
	  && ((*(tmp2 + 1) == ' '  || *tmp2 == '\t')
	      || *(tmp2 + 1) == '\0'
	      || *(tmp2 - 1) == '\0'))
	while (*tmp2 == ' ' || *tmp2 == '\t')
	  tmp2++;
      else
	*tmp1++ = *tmp2++;
    }
  *tmp1 = 0;
  return str;
  */

  int ite1 = 0, ite2 = 0;

  while (str[ite1])
    {
      if ((str[ite1] == ' ' || str[ite1] == '\t')
	  && ((str[ite1 + 1] == ' ' || str[ite1] == '\t')
	      || str[ite1 + 1] == '\0'
	      || ite1 == 0))
	while (str[ite1] == ' ' || str[ite1] == '\t')
	  ++ite1;
      else
	str[ite2++] = str[ite1++];
    }
  str[ite2] = 0;
  return str;
}

/*
** Removes all newlines in the string
**
** @param: char *str - string
** @return: Char* - return Char* param
*/
char	*filter_newline(char *str)
{
  /*
  char *tmp1 = str;
  char *tmp2 = str;

  while (*tmp2)
    {
      if (*tmp2 == '\n'
	  && (*(tmp2 + 1) == '\n'
	      || *(tmp2 + 1) == '\0'
	      || *(tmp2 - 1) == '\0'))
	{
	  tmp2++;
	}
      else
	*tmp1++ = *tmp2++;
    }
  *tmp1 = 0;
  return str;
  */

  int ite1 = 0, ite2 = 0;

    while (str[ite1])
    {
      if (str[ite1] == '\n'
	  && (str[ite1 + 1] == '\n'
	      || str[ite1 + 1] == '\0'
	      || ite1 == 0))
	++ite1;
      else
	str[ite2++] = str[ite1++];
    }
  str[ite2] = 0;
  return str;
}
