From: Li Wang <liwang@redhat.com>
Date: Wed, 4 Nov 2020 21:20:24 +0800
Subject: [LTP] [PATCH v2 03/11] docparse: Add test documentation parser
In-Reply-To: <20201104073008.GB8632@pevik>
References: <20201103191327.11081-1-pvorel@suse.cz>
 <20201103191327.11081-4-pvorel@suse.cz>
 <20201104073008.GB8632@pevik>
Message-ID: <CAEemH2dx2wYT0dHcDnFnZ0sqY8MO1QOb1-qEmgRSPdFLO=9NUw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 4, 2020 at 3:30 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> > --- /dev/null
> > +++ b/docparse/docparse.c
>
> ...
> > +const char *next_token(FILE *f, struct data_node *doc)
> > +{
> > +     size_t i = 0;
> > +     static char buf[4096];
> > +     int c;
> > +     int in_str = 0;
> > +
> > +     for (;;) {
> > +             c = fgetc(f);
> > +
> > +             if (c == EOF)
> > +                     goto exit;
> > +
> > +             if (in_str) {
> > +                     if (c == '"') {
> > +                             if (i == 0 || buf[i-1] != '\\') {
> > +                                     buf[i++] = c;
> > +                                     goto exit;
> > +                             }
> IMHO this change (adding buf[i++] = c;), which Li suggested,
> is causing build failures:
> https://travis-ci.org/github/pevik/ltp/builds/741217630
>
> /usr/src/ltp/docparse/testinfo.pl metadata.json
> , or ] expected while parsing array, at character offset 340 (before
> "",\n      "0c461cb72...") at /usr/src/ltp/docparse/testinfo.pl line 379.
> make[1]: *** [/usr/src/ltp/docparse/Makefile:60: txt] Error 255
> make[1]: Leaving directory '/usr/src/ltp-build/docparse'
> make: *** [/usr/src/ltp/Makefile:108: docparse-all] Error 2
> make: *** Waiting for unfinished jobs....
>

Sorry for the error, it because of wrongly parsed tst_test struct with
including .min_kver = "2.6.32",  then output into metada.json like:

# cat metadata.json
...
  "cpuset01": {
   "needs_root": "1",
   "forks_child": "1",
   "min_kver": "2.6.32"",  <====== here has two "" in the end
   "fname": "testcases/kernel/mem/cpuset/cpuset01.c"
  },

So the "$(abs_srcdir)/testinfo.pl metadata.json" in Makefile report failure
as above.

==========

Another fix I can think of is just to avoid return NULL if detecting in the
string("").
Hope this will work for us, I will help to check it again tomorrow.

--- a/docparse/docparse.c
+++ b/docparse/docparse.c
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
@@ -189,7 +187,7 @@ const char *next_token(FILE *f, struct data_node *doc)
        }

 exit:
-       if (i == 0)
+       if (i == 0 && !in_str)
                return NULL;

        buf[i] = 0;


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201104/56373c64/attachment-0001.htm>
