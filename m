From: Li Wang <liwang@redhat.com>
Date: Thu, 12 Oct 2017 16:47:32 +0800
Subject: [LTP] [PATCH 5/6] creat07: no need to pass tst_ipc_envp anymore
In-Reply-To: <20171012080802.GA10492@rei>
References: <7fe9947329b48673f7f9ee2e0b127619fdfe0c34.1507647255.git.jstancek@redhat.com>
 <70f47d3c63fb849eeba0a6bb4f2760d4815db3cb.1507647255.git.jstancek@redhat.com>
 <20171012080802.GA10492@rei>
Message-ID: <CAEemH2e7e-LdS-21SVj=Kyqni64WsTz7P_bdhOiFHEEP0evHNA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Oct 12, 2017 at 4:08 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>> ---
>>  testcases/kernel/syscalls/creat/creat07.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
>> index e1b267661c39..236f4edf843f 100644
>> --- a/testcases/kernel/syscalls/creat/creat07.c
>> +++ b/testcases/kernel/syscalls/creat/creat07.c
>> @@ -38,9 +38,7 @@ static void verify_creat(void)
>>
>>       pid = SAFE_FORK();
>>       if (pid == 0) {
>> -             char *av[] = {TEST_APP, NULL};
>> -             (void)execve(TEST_APP, av, tst_ipc_envp);
>> -             perror("execve failed");
>> +             SAFE_EXECLP(TEST_APP, TEST_APP, NULL);
>
> And it looks like this broke the test when executed from installed LTP,
> that is because the execlp() picks up the TEST_APP from

Yes, I also hit the problem when running creat07 with LTP framework.

# /opt/ltp/runltp -s creat07
...
incrementing stop
tst_test.c:958: INFO: Timeout per run is 0h 05m 00s
creat07.c:50: FAIL: creat() succeeded unexpectedly
^Cincrementing stop
Sending SIGKILL to test process...
tst_test.c:1008: INFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1009: BROK: Test killed! (timeout?)


> /opt/ltp/testcasese/bin/ instead of the local copy. I guess that we have
> to use exec() variant without the p at the end here.

Right! After replacing the execlp() with execl(), the issue is gone.

# /opt/ltp/runltp -s creat07
...
incrementing stop
tst_test.c:958: INFO: Timeout per run is 0h 05m 00s
creat07.c:55: PASS: creat() received EXTBSY

Summary:
passed   1
failed   0
skipped  0
warnings 0


------------------
$ git diff
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 5d89525..a865cbd 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -403,6 +403,12 @@ static inline sighandler_t safe_signal(const char
*file, const int lineno,
                 "execlp(%s, %s, ...) failed", file, arg); \
        } while (0)

+#define SAFE_EXECL(file, arg, ...) do {                   \
+       execl((file), (arg), ##__VA_ARGS__);              \
+       tst_brk_(__FILE__, __LINE__, TBROK | TERRNO,       \
+                "execlp(%s, %s, ...) failed", file, arg); \
+       } while (0)
+
 int safe_getpriority(const char *file, const int lineno, int which, id_t who);
 #define SAFE_GETPRIORITY(which, who) \
        safe_getpriority(__FILE__, __LINE__, (which), (who))
diff --git a/testcases/kernel/syscalls/creat/creat07.c
b/testcases/kernel/syscalls/creat/creat07.c
index 236f4ed..a016604 100644
--- a/testcases/kernel/syscalls/creat/creat07.c
+++ b/testcases/kernel/syscalls/creat/creat07.c
@@ -38,7 +38,7 @@ static void verify_creat(void)

        pid = SAFE_FORK();
        if (pid == 0) {
-               SAFE_EXECLP(TEST_APP, TEST_APP, NULL);
+               SAFE_EXECL(TEST_APP, TEST_APP, NULL);
                exit(1);
        }





-- 
Li Wang
liwang@redhat.com
