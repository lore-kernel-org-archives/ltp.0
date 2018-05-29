From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 29 May 2018 15:03:56 +0800
Subject: [LTP] [PATCH] pty: using tcgetattr() to get attributes before
 re-setting it
In-Reply-To: <20180528103936.22538-1-liwang@redhat.com>
References: <20180528103936.22538-1-liwang@redhat.com>
Message-ID: <5B0CFB5C.5040702@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

We found other issues by running pty02:
1) The undefined EXTPROC flag led to complier error on RHEL5/6.
2) Based on the fix, reading pts blocked on RHEL6 because we didn't write newline('\n') to ptmx,
    but it worked well on RHEL7.  I am not sure which kernel patch changed this behavior.
    According canonical mode description:
        In canonical mode:
        * Input is made available line by line.  An input line is available when one of the line
          delimiters is typed (NL, EOL, EOL2; or EOF at the start of line).  Except in the case of EOF,
          the line delimiter is included in the buffer returned by read(2).
3) Based on the fix, tcsetattr(3) cannot detect invalid EXTPROC flag on RHEL5/6.

Thanks,
Xiao Yang

On 2018/05/28 18:39, Li Wang wrote:
> To fix this error:
>    tst_test.c:1015: INFO: Timeout per run is 0h 50m 00s
>    pty02.c:42: BROK: tcsetattr() failed: EINVAL
>
> POSIX.1 General description:
>    Changes the attributes associated with a terminal. New attributes are
>    specified with a termios control structure. Programs should always
>    issue a tcgetattr() first, modify the desired fields, and then issue
>    a tcsetattr(). tcsetattr() should never be issued using a termios
>    structure that was not obtained using tcgetattr(). tcsetattr() should
>    use only a termios structure that was obtained by tcgetattr().
>
> Signed-off-by: Li Wang<liwang@redhat.com>
> Cc: Eric Biggers<ebiggers@google.com>
> Cc: Cyril Hrubis<chrubis@suse.cz>
> ---
>   testcases/kernel/pty/pty02.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/pty/pty02.c b/testcases/kernel/pty/pty02.c
> index fd3d26b..0cedca8 100644
> --- a/testcases/kernel/pty/pty02.c
> +++ b/testcases/kernel/pty/pty02.c
> @@ -31,13 +31,18 @@
>
>   static void do_test(void)
>   {
> -	struct termios io = { .c_lflag = EXTPROC | ICANON };
> +	struct termios io;
>   	int ptmx, pts;
>   	char c = 'A';
>   	int nbytes;
>
>   	ptmx = SAFE_OPEN("/dev/ptmx", O_WRONLY);
>
> +	if (tcgetattr(ptmx,&io) != 0)
> +		tst_brk(TBROK | TERRNO, "tcgetattr() failed");
> +
> +	io.c_lflag = EXTPROC | ICANON;
> +
>   	if (tcsetattr(ptmx, TCSANOW,&io) != 0)
>   		tst_brk(TBROK | TERRNO, "tcsetattr() failed");
>



