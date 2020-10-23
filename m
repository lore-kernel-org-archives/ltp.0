From: Li Wang <liwang@redhat.com>
Date: Fri, 23 Oct 2020 15:01:27 +0800
Subject: [LTP] [PATCH 03/11] docparse: Add test documentation parser
In-Reply-To: <20201005133054.23587-4-chrubis@suse.cz>
References: <20201005133054.23587-1-chrubis@suse.cz>
 <20201005133054.23587-4-chrubis@suse.cz>
Message-ID: <CAEemH2e397yh+sa68_YkHwEr+QAV+NC0ROhbXHUm0CvrEd9gng@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> wrote:

> +const char *next_token(FILE *f, struct data_node *doc)
> +{
> +       size_t i = 0;
> +       static char buf[4096];
> +       int c;
> +       int in_str = 0;
> +
> +       for (;;) {
> +               c = fgetc(f);
> +
> +               if (c == EOF)
> +                       goto exit;
> +
> +               if (in_str) {
> +                       if (c == '"') {
> +                               if (i == 0 || buf[i-1] != '\\')
> +                                       goto exit;
> +                       }

There is a problem in handle a special string token here,
which can not parse the "" correctly in many test cases.

e.g.

# ./docparse ../testcases/kernel/syscalls/fsopen/fsopen01.c
# ./docparse ../testcases/kernel/fs/ftest/ftest02.c
....

We got nothing output from the above two tests parsing because they
contains "" in their sentence, it makes next_token() exit too early.

     TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
            MOVE_MOUNT_F_EMPTY_PATH));


> +
> +                       buf[i++] = c;
> +                       continue;
> +               }
> +
> +               switch (c) {
> +               case '{':
> +               case '}':
> +               case ';':
> +               case '(':
> +               case ')':
> +               case '=':
> +               case ',':
> +               case '[':
> +               case ']':
> +                       if (i) {
> +                               ungetc(c, f);
> +                               goto exit;
> +                       }
> +
> +                       buf[i++]=c;
> +                       goto exit;
> +               case '0' ... '9':
> +               case 'a' ... 'z':
> +               case 'A' ... 'Z':
> +               case '.':
> +               case '_':
> +               case '-':
> +                       buf[i++]=c;
> +               break;
> +               case '/':
> +                       maybe_comment(f, doc);
> +               break;
> +               case '"':
> +                       in_str = 1;
> +               break;
> +               case ' ':
> +               case '\n':
> +               case '\t':
> +                       if (i)
> +                               goto exit;
> +               break;
> +               }
> +       }
> +
> +exit:
> +       if (i == 0)
> +               return NULL;
> +
> +       buf[i] = 0;
> +       return buf;
> +}
> +
> +#define WARN(str) fprintf(stderr, str "\n")
> +
> +static int parse_array(FILE *f, struct data_node *node)
> +{
> +       const char *token;
> +
> +       for (;;) {
> +               if (!(token = next_token(f, NULL)))
> +                       return 1;
> +
> +               if (!strcmp(token, "{")) {
> +                       struct data_node *ret = data_node_array();
> +                       parse_array(f, ret);
> +
> +                       if (data_node_array_len(ret))
> +                               data_node_array_add(node, ret);
> +                       else
> +                               data_node_free(ret);
> +
> +                       continue;
> +               }
> +
> +               if (!strcmp(token, "}"))
> +                       return 0;
> +
> +               if (!strcmp(token, ","))
> +                       continue;
> +
> +               if (!strcmp(token, "NULL"))
> +                       continue;
> +
> +               struct data_node *str = data_node_string(token);
> +
> +               data_node_array_add(node, str);
> +       }
> +
> +       return 0;
> +}
> +
> +static const char *tokens[] = {
> +       "static",
> +       "struct",
> +       "tst_test",
> +       "test",
> +       "=",
> +       "{",
> +};
> +
> +static struct data_node *parse_file(const char *fname)
> +{
> +       int state = 0, found = 0;
> +       const char *token;
> +

Seems we'd better check the fname is valid before opening it.

       if (access(fname, F_OK)) {
               fprintf(stderr, "file %s is not exist\n", fname);
               return NULL;
       }

> +static const char *filter_out[] = {
> +       "test",
> +       "test_all",
> +       "setup",
> +       "cleanup",
> +       "tcnt",
> +       "mntpoint",
> +       "bufs",

I guess the "options"  should be also filtered out here?

--
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201023/483b507f/attachment-0001.htm>
