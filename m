From: Chunyu Hu <chuhu@redhat.com>
Date: Wed, 4 May 2016 11:04:10 -0400 (EDT)
Subject: [LTP] [PATCH V2 6/9] testcases/lib: Add tst_random decmical
 integer generator
In-Reply-To: <20160504133453.GD12244@rei.lan>
References: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
 <1460966656-28328-2-git-send-email-chuhu@redhat.com>
 <1460966656-28328-3-git-send-email-chuhu@redhat.com>
 <1460966656-28328-4-git-send-email-chuhu@redhat.com>
 <1460966656-28328-5-git-send-email-chuhu@redhat.com>
 <1460966656-28328-6-git-send-email-chuhu@redhat.com>
 <1460966656-28328-7-git-send-email-chuhu@redhat.com>
 <20160504133453.GD12244@rei.lan>
Message-ID: <107593102.43362349.1462374250852.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

Thank you for the quick review, will submit a new version soon,

Other tests indeed referenced this helper. Also added some comment

below.

----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Chunyu Hu" <chuhu@redhat.com>
> Cc: ltp@lists.linux.it, liwan@redhat.com
> Sent: Wednesday, May 4, 2016 9:34:53 PM
> Subject: Re: [LTP] [PATCH V2 6/9] testcases/lib: Add tst_random decmical integer generator
> 
> Hi!
> >  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> > diff --git a/testcases/lib/tst_random.c b/testcases/lib/tst_random.c
> > new file mode 100644
> > index 0000000..91a5247
> > --- /dev/null
> > +++ b/testcases/lib/tst_random.c
> > @@ -0,0 +1,104 @@
> > +/*
> > + * Copyright (c) 2016 Red Hat Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of
> > + * the License, or (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it would be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write the Free Software Foundation,
> > + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > + *
> > + * Author: Chunyu Hu <chuhu@redhat.com>
> > + *
> > + */
> > +
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/time.h>
> > +
> > +static void print_help(void)
> > +{
> > +	printf("Usage: tst_random <value1> [value2]\n");
> > +	printf("       Generated random will be between value1 and value2.\n");
> > +	printf("       If only value1 is specified, value2 will treated as
> > 0.\n");
> > +}
> > +
> > +static int get_seed(void)
> > +{
> > +	struct timeval tv;
> > +	gettimeofday(&tv, NULL);
> > +	return tv.tv_usec;
> > +}
> > +
> > +static long rand_range(long min, long max)
> > +{
> > +	return rand() % (max - min + 1) + min;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	int opt;
> > +	long min = 0, max = 0, tmp = 0;
> > +	long rval = 0;
> > +	char *end;
> > +
> > +	while ((opt = getopt(argc, argv, ":h")) != -1) {
> > +		switch (opt) {
> > +		case 'h':
> > +			print_help();
> > +			return 0;
> > +		default:
> > +			print_help();
> > +			return 1;
> > +		}
> > +	}
> > +
> > +	if (argc < 2 || argc > 3) {
> > +		print_help();
> > +		return 1;
> > +	}
> > +
> > +	if (optind >= argc) {
> > +		fprintf(stderr, "ERROR: Expected one or two range_val arguments\n\n");
> > +		print_help();
> > +		return 1;
> > +	}
> 
> We exit if getopt() finds any options in argv[] so optind == 1 here and
> since we check for argc < 2 before this this if is never true.

Good analysis, so this should be removed in next step.

> 
> > +	max = strtol(argv[optind], &end, 10);
> 
> Here as well optind == 1 by definition.

Ok, will use 1 directly next step.

> 
> > +	if (argv[optind] == end) {
> > +		fprintf(stderr, "ERROR: Invalid range value1 '%s'\n\n",
> > +			argv[optind]);
> > +		print_help();
> > +		return 1;
> > +	}
> 
> Well if we bother with strtol() we may check that argv[1] != '\0' and
> end == '\0' which will ensure that whole parameter was a valid string.

Looks like we just need to compare with ( *end != '\0' ), as argv[1] or 
argv[2] can't be '\0' (NULL) as it has been filtered by (argc <2 || argc > 3).

And i just verified this with this debug line: 

   printf("end = %p, *end = %c\n", end, *end);


> > +	if (argc == 3) {
> > +		min = strtol(argv[optind+1], &end, 10);
> 
> Here as well use just 2 instead of optind + 1.

OK. Agree.

> 
> > +		if (argv[optind+1] == end) {
> > +			fprintf(stderr, "ERROR: Invalid range value2 '%s'\n\n",
> > +				argv[optind+1]);
> > +			print_help();
> > +			return 1;
> > +		}
> > +		if (min > max) {
> > +			tmp = min;
> > +			min = max;
> > +			max = tmp;
> > +		}
> 
> Well we may also do:
> 
> 	rval = (min > max) ? rand_range(max, min) : rand_range(min, max);


Thanks for this good advise, i really like this style.

> In the code below instead, but that is merely cosmetic.

Thanks.

> 
> > +	}
> > +
> > +	srand(get_seed());
> > +	rval = rand_range(min, max);
> > +	printf("%ld\n", rval);
> > +
> > +	return rval;
> 
> We should just return 0 here since the return value is limited to one
> byte. Exporting interface that works only in certain cases is a recipe
> for a disaster.

Thanks for catching this, can't agree more. Will fix this line in next 
step.

> --
> Cyril Hrubis
> chrubis@suse.cz
> 

-- 
Regards,
Chunyu Hu

