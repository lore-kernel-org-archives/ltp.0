From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 Jun 2018 15:30:21 +0200
Subject: [LTP] [PATCH v3] change type of variable to fix compile warning
In-Reply-To: <20180615103955.14757-1-sunlw.fnst@cn.fujitsu.com>
References: <20180615103955.14757-1-sunlw.fnst@cn.fujitsu.com>
Message-ID: <20180615133021.avruxun6js6j3wk3@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Sun,

I'm sorry, I'm not going to take this patch.  Don't take it wrong, I really
appreciate this effort. There are my reasons why not taking it:

1) Main reason is that fixes like this doesn't help much.  Even it's correct
fix, these tests have more serious problems.  Fixes like this make sense in
clean tests.
None of these tests has been rewritten to the new API (which is efficient, old
API suffers several flaws).  While rewriting maybe half of the loops get removed
anyway. Rewriting also requires evaluating, whether tests are meaningful and do
the right thing, some of the test might get deleted completely.

So taking one of these tests, understand what it does, rewrite it into new API
and cleanup the trash and maybe add what is missing would help more
See example of nice rewrite: Rewrite msgctl testcases Cyril Hrubis [1], [2].
(that's a bigger patch, one test would be enough).

Examples of more serious errors, which we should pay attention:
  fsx-linux.c: In function ‘main’:                                                                                                      
  fsx-linux.c:1180:25: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]                                   
      if (progressinterval < 0)

2) You introduced a bug:
  ftruncate03.c: In function ‘main’:                                                                                                    
  ftruncate03.c:117:49: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
     if ((count += write(wjh_f, str, strlen(str))) == -1) {

count here needs to be signed int and the correct fix would be cast it to int:
-       while (count < strlen(str)) {
+       while (count < (int)strlen(str)) {

3) When I ask you to fix all the comparison warnings, I meant in the files which
you already changed. You introduced more files, but still you left some
comparisons unfixed there:
msync01.c:170:17:
move_pages_support.c:91:8:
msync02.c:125:17:
remap_file_pages01.c:155:17:
remap_file_pages02.c:290:17:

Other minor errors (which would otherwise be fixed by committer):
> +++ b/testcases/kernel/containers/pidns/pidns17.c
> @@ -58,7 +58,8 @@ int child_fn(void *);
>   */
>  int child_fn(void *arg)
>  {
> -	int children[10], exit_val, i, status;
> +	int children[10], exit_val, status;
> +	unsigned i;
You're mixing 'unsigned int' and 'unsigned'. It'd be better to be consistent and
use 'unsigned int'.


> +++ b/testcases/kernel/syscalls/ftruncate/ftruncate03.c
> @@ -59,7 +59,8 @@ int TST_TOTAL = 3;

>  int main(void)
>  {
> -	int wjh_ret = -1, wjh_f = -1, count = 0;
> +	int wjh_ret = -1, wjh_f = -1;
> +    unsigned int count = 0;
Mixing tab and spaces.


Kind regards,
Petr

[1] https://lists.linux.it/pipermail/ltp/2018-June/008402.html
[2] https://patchwork.ozlabs.org/project/ltp/list/?series=49764
