From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Oct 2017 10:08:02 +0200
Subject: [LTP] [PATCH 5/6] creat07: no need to pass tst_ipc_envp anymore
In-Reply-To: <70f47d3c63fb849eeba0a6bb4f2760d4815db3cb.1507647255.git.jstancek@redhat.com>
References: <7fe9947329b48673f7f9ee2e0b127619fdfe0c34.1507647255.git.jstancek@redhat.com>
 <70f47d3c63fb849eeba0a6bb4f2760d4815db3cb.1507647255.git.jstancek@redhat.com>
Message-ID: <20171012080802.GA10492@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/creat/creat07.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
> index e1b267661c39..236f4edf843f 100644
> --- a/testcases/kernel/syscalls/creat/creat07.c
> +++ b/testcases/kernel/syscalls/creat/creat07.c
> @@ -38,9 +38,7 @@ static void verify_creat(void)
>  
>  	pid = SAFE_FORK();
>  	if (pid == 0) {
> -		char *av[] = {TEST_APP, NULL};
> -		(void)execve(TEST_APP, av, tst_ipc_envp);
> -		perror("execve failed");
> +		SAFE_EXECLP(TEST_APP, TEST_APP, NULL);

And it looks like this broke the test when executed from installed LTP,
that is because the execlp() picks up the TEST_APP from
/opt/ltp/testcasese/bin/ instead of the local copy. I guess that we have
to use exec() variant without the p at the end here.

-- 
Cyril Hrubis
chrubis@suse.cz
