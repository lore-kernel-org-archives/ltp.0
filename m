From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Mar 2018 13:01:34 +0100
Subject: [LTP] [PATCH] ksm: perform cleanup actions only when they are
 actually required
In-Reply-To: <1521472983-7383-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1521472983-7383-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20180320120134.GB9226@ai>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static int max_page_sharing_saved;
> +
>  static void verify_ksm(void)
>  {
>  	create_same_memory(size, num, unit);
> @@ -70,6 +72,7 @@ static void setup(void)
>  		tst_brk(TCONF, "KSM configuration is not enabled");
>  
>  	save_max_page_sharing();
> +	max_page_sharing_saved = 1;

Given that we have the save_max_page_sharing() and
restore_max_page_sharing() functions it would be cleaner to put the flag
that tells us if we should restore it to the lib/mem.c so that we do not
have to repeat the code in all testcases.

Looking into kernel documentation is says that minimum for the
max_page_sharing is 2 so we may as well just do:

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 4992843f4..eedfe260f 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -250,6 +250,9 @@ void save_max_page_sharing(void)
 
 void restore_max_page_sharing(void)
 {
+       if (!max_page_sharing)
+               return;
+
        if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
                FILE_PRINTF(PATH_KSM "max_page_sharing",
                                 "%d", max_page_sharing);

-- 
chrubis@suse.cz
