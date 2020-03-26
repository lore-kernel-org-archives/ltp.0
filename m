From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 26 Mar 2020 12:12:40 +0100
Subject: [LTP] [PATCH] Add test for CVE 2018-1000199
In-Reply-To: <20200326063638.GB5206@dell5510>
References: <20200319162114.3967-1-mdoucha@suse.cz>
 <20200326055639.GA5206@dell5510> <20200326063638.GB5206@dell5510>
Message-ID: <117b0eb0-984b-eb95-b65e-e92c9a206a95@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 26. 03. 20 7:36, Petr Vorel wrote:
> Hi Martin,
> 
>>> +TST_TEST_CONF("This test is only supported on x86 systems")
>> FYI there is TST_TEST_TCONF().
> + There needs to be semicolon after the macro (we could change this
> in the library.
>>> +#endif

I really should have tried compiling this on some other arch. *facepalm*

> I'd also put adding SAFE_PTRACE() into separate commit.
> 
> You can also use SAFE_FOPEN() for *fr.

Will fix.

> On some machines I got TBROK, but we probably cannot avoid it. 
> ptrace08.c:119: BROK: Received unexpected event from child

Hmm, could you apply the following patch and send me the output from
those machines?

diff --git a/testcases/kernel/syscalls/ptrace/ptrace08.c
b/testcases/kernel/syscalls/ptrace/ptrace08.c
index 4db433782..08ebe641a 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace08.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace08.c
@@ -117,6 +117,25 @@ static void run(void)
 	if (SAFE_WAITPID(child, &status, 0) != child)
 		tst_brk(TBROK, "Received event from unexpected PID");

+	if (WIFEXITED(status))
+		tst_res(TINFO, "Child exited: %d", WEXITSTATUS(status));
+
+	if (WIFSIGNALED(status))
+		tst_res(TINFO, "Child received signal: %s",
+			tst_strsig(WTERMSIG(status)));
+
+#ifdef WCOREDUMP
+	if (WCOREDUMP(status))
+		tst_res(TINFO, "Child dumped core");
+#endif
+
+	if (WIFSTOPPED(status))
+		tst_res(TINFO, "Child stopped by signal: %s",
+			tst_strsig(WTERMSIG(status)));
+
+	if (WIFCONTINUED(status))
+		tst_res(TINFO, "Child execution resumed by SIGCONT");
+
 	if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGTRAP)
 		tst_brk(TBROK, "Received unexpected event from child");


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
