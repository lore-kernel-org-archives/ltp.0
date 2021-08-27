From: John Stultz <john.stultz@linaro.org>
Date: Fri, 27 Aug 2021 21:29:59 +0000
Subject: [LTP] [RFC][PATCH] memcg/control: Fix dropped messages from fifo to
 avoid leaving mem_process running
Message-ID: <20210827212959.1633818-1-john.stultz@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

(Sorry for the resend, had to subscribe to the list)

In testing with AOSP, I ran across some odd behavior where
the memcg_control_test.sh would get stuck in zombie state,
and the mem_process process would be stuck running.

After some debugging, I found mem_process was not getting
the quit message ("x") over the status_pipe fifo, and would
keep running after the test was finished.

In the memcg_control_test.sh script, there is some curious
behavior, as after it sends the allocate message ("m") and
then checks to see if the mem_process has been killed, if it
was not killed, it again sends the allocate ("m") message,
which I don't quite understand the reason for:
  https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/controllers/memcg/control/memcg_control_test.sh#L72

The memcg_control_test.sh then immediately sends the quit
message ("x"):
  https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/controllers/memcg/control/memcg_control_test.sh#L73

Which is what the mem_process was not receiving.

Removing the second allocate ("m") message seemed to avoid the
problem. And digging further this seems to be due to the fact
that the mem_process is open/read/closing the fifo each loop
iteration:
  https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/controllers/memcg/control/mem_process.c#L109

My understanding is fifos only function when both sides are
open, having two commands sent quickly in succession, the first
will be read but as the fifo is then closed, the second message
may get dropped before the fifo is re-opened and read from.

Thus to avoid this, this patch reworks the fifo handling so
the mem_process will create the fifo, open it, and then
do its main loop processing keeping the fifo open.

Once it receieves a quit message, it will then close and
remove the fifo.

So far this has resolved the issue for me.
I don't pretend to be a fifo expert, so feedback or suggestions
for other approaches would be welcome!

Cc: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: Jan Stancek <jstancek@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: YongQin Liu <yongqin.liu@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../controllers/memcg/control/mem_process.c      | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/control/mem_process.c b/testcases/kernel/controllers/memcg/control/mem_process.c
index efe2fb3e3..6c1b36ca6 100644
--- a/testcases/kernel/controllers/memcg/control/mem_process.c
+++ b/testcases/kernel/controllers/memcg/control/mem_process.c
@@ -101,25 +101,20 @@ void mem_map(void)
 /*
  * done: retrieve instructions from the named pipe
  */
-char action(void)
+char action(int fd)
 {
 	char ch;
-	int fd;
-
-	if ((fd = open(STATUS_PIPE, O_RDONLY)) == -1)
-		err(6, "Error opening named pipe");
 
 	if (read(fd, &ch, 1) == -1)
 		err(7, "Error reading named pipe");
 
-	close(fd);
-
 	return ch;
 }
 
 int main(int argc, char **argv)
 {
 	int ret;
+	int fd;
 	char ch;
 
 	process_options(argc, argv);
@@ -129,13 +124,18 @@ int main(int argc, char **argv)
 	if (ret == -1 && errno != EEXIST)
 		errx(1, "Error creating named pipe");
 
+	if ((fd = open(STATUS_PIPE, O_RDONLY)) == -1)
+		err(6, "Error opening named pipe");
+
 	do {
-		ch = action();
+		ch = action(fd);
 
 		if (ch == 'm')
 			mem_map();
 	} while (ch != 'x');
 
+	close(fd);
+
 	remove(STATUS_PIPE);
 
 	return 0;
-- 
2.25.1

