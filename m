From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Nov 2020 08:30:08 +0100
Subject: [LTP] [PATCH v2 03/11] docparse: Add test documentation parser
In-Reply-To: <20201103191327.11081-4-pvorel@suse.cz>
References: <20201103191327.11081-1-pvorel@suse.cz>
 <20201103191327.11081-4-pvorel@suse.cz>
Message-ID: <20201104073008.GB8632@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> --- /dev/null
> +++ b/docparse/docparse.c

...
> +const char *next_token(FILE *f, struct data_node *doc)
> +{
> +	size_t i = 0;
> +	static char buf[4096];
> +	int c;
> +	int in_str = 0;
> +
> +	for (;;) {
> +		c = fgetc(f);
> +
> +		if (c == EOF)
> +			goto exit;
> +
> +		if (in_str) {
> +			if (c == '"') {
> +				if (i == 0 || buf[i-1] != '\\') {
> +					buf[i++] = c;
> +					goto exit;
> +				}
IMHO this change (adding buf[i++] = c;), which Li suggested,
is causing build failures:
https://travis-ci.org/github/pevik/ltp/builds/741217630

/usr/src/ltp/docparse/testinfo.pl metadata.json
, or ] expected while parsing array, at character offset 340 (before "",\n      "0c461cb72...") at /usr/src/ltp/docparse/testinfo.pl line 379.
make[1]: *** [/usr/src/ltp/docparse/Makefile:60: txt] Error 255
make[1]: Leaving directory '/usr/src/ltp-build/docparse'
make: *** [/usr/src/ltp/Makefile:108: docparse-all] Error 2
make: *** Waiting for unfinished jobs....

It's strange that it's not failing in all tests.

Anyway, test is working without it:
https://travis-ci.org/github/pevik/ltp/builds/741322879

@@ -138,10 +138,8 @@ const char *next_token(FILE *f, struct data_node *doc)

                if (in_str) {
                        if (c == '"') {
-                               if (i == 0 || buf[i-1] != '\\') {
-                                       buf[i++] = c;
+                               if (i == 0 || buf[i-1] != '\\')
                                        goto exit;
-                               }
                        }

                        buf[i++] = c;
----

Li, could you please comment?

Kind regards,
Petr
