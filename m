From: Li Wang <liwang@redhat.com>
Date: Fri, 23 Oct 2020 17:36:26 +0800
Subject: [LTP] [PATCH 03/11] docparse: Add test documentation parser
In-Reply-To: <CAEemH2e397yh+sa68_YkHwEr+QAV+NC0ROhbXHUm0CvrEd9gng@mail.gmail.com>
References: <20201005133054.23587-1-chrubis@suse.cz>
 <20201005133054.23587-4-chrubis@suse.cz>
 <CAEemH2e397yh+sa68_YkHwEr+QAV+NC0ROhbXHUm0CvrEd9gng@mail.gmail.com>
Message-ID: <CAEemH2cKVRnSbifdEmjxdTX3Pkmvy5cwcZWQ8QBTVK0g2xA+0A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Oct 23, 2020 at 3:01 PM Li Wang <liwang@redhat.com> wrote:

>
> Cyril Hrubis <chrubis@suse.cz> wrote:
>
> > +const char *next_token(FILE *f, struct data_node *doc)
> > +{
> > +       size_t i = 0;
> > +       static char buf[4096];
> > +       int c;
> > +       int in_str = 0;
> > +
> > +       for (;;) {
> > +               c = fgetc(f);
> > +
> > +               if (c == EOF)
> > +                       goto exit;
> > +
> > +               if (in_str) {
> > +                       if (c == '"') {
> > +                               if (i == 0 || buf[i-1] != '\\')
> > +                                       goto exit;
> > +                       }
>
> There is a problem in handle a special string token here,
> which can not parse the "" correctly in many test cases.
>
> e.g.
>
> # ./docparse ../testcases/kernel/syscalls/fsopen/fsopen01.c
> # ./docparse ../testcases/kernel/fs/ftest/ftest02.c
>

The ftest02.c has not been converted to new API, please ignore.

To fix this problem I propose to add a simple line as:

@@ -137,8 +138,10 @@ const char *next_token(FILE *f, struct data_node *doc)

                if (in_str) {
                        if (c == '"') {
-                               if (i == 0 || buf[i-1] != '\\')
+                               if (i == 0 || buf[i-1] != '\\') {
+                                       buf[i++] = c;
                                        goto exit;
+                               }
                        }



> ....
>
> We got nothing output from the above two tests parsing because they
> contains "" in their sentence, it makes next_token() exit too early.
>
>      TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
>             MOVE_MOUNT_F_EMPTY_PATH));
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201023/6111a36b/attachment.htm>
