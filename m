From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 12 Aug 2021 06:38:07 +0200
Subject: [LTP] [PATCH v2 2/2] pec: Improve reliability
In-Reply-To: <20210812043807.3497492-1-lkml@jv-coder.de>
References: <20210812043807.3497492-1-lkml@jv-coder.de>
Message-ID: <20210812043807.3497492-2-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

This fixes two problems:
1. It was possible, that the event listener was terminated,
before all events were recorded.
The listener now terminates, after receiving the exit event of the generator.
This also gets rid of the 100ms sleep in cn_pec.sh by
using proper synchronization points.
2. Sometimes exit events were generated in the wrong order,
Adding a short delay seems to solve this. While this adds in a new sleep,
it is just a 1 ms for default the execution.

Reported-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/kernel/connectors/pec/cn_pec.sh     | 36 ++++---
 .../kernel/connectors/pec/event_generator.c   | 97 ++++++++++---------
 .../kernel/connectors/pec/pec_listener.c      | 56 ++++++++++-
 3 files changed, 128 insertions(+), 61 deletions(-)

diff --git a/testcases/kernel/connectors/pec/cn_pec.sh b/testcases/kernel/connectors/pec/cn_pec.sh
index 9b85a5c81..74e94dc5e 100755
--- a/testcases/kernel/connectors/pec/cn_pec.sh
+++ b/testcases/kernel/connectors/pec/cn_pec.sh
@@ -16,12 +16,16 @@ TST_PARSE_ARGS=parse_args
 TST_USAGE=usage
 TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
+TST_NEEDS_CHECKPOINTS=1
 TST_TEST_DATA="fork exec exit uid gid"
 
 . tst_test.sh
 
 num_events=10
 
+LISTENER_ID=0
+GENERATOR_ID=1
+
 usage()
 {
 	cat << EOF
@@ -67,27 +71,31 @@ setup()
 test()
 {
 	local event=$2
-	local expected_events lis_rc pid fd_act failed act_nevents exp act
+	local gen_pid list_pid gen_rc lis_rc
+	local expected_events fd_act failed act_nevents exp act
 
 	tst_res TINFO "Testing $2 event (nevents=$num_events)"
 
-	pec_listener >lis_$event.log 2>lis_$event.err &
-	pid=$!
-	# wait for pec_listener to start listening
-	tst_sleep 100ms
+	event_generator -n $num_events -e $event -c $GENERATOR_ID >gen.log &
+	gen_pid=$!
+
+	pec_listener -p $gen_pid -c $LISTENER_ID >lis.log &
+	lis_pid=$!
 
-	ROD event_generator -n $num_events -e $event \>gen_$event.log 2\>gen_$event.err
+	TST_CHECKPOINT_WAIT $LISTENER_ID
+	TST_CHECKPOINT_WAKE $GENERATOR_ID
 
-	kill -s INT $pid 2> /dev/null
-	wait $pid
+	wait $gen_pid
+	gen_rc=$?
+	wait $lis_pid
 	lis_rc=$?
 
-	if [ ! -s gen_$event.log ]; then
-		tst_brk TBROK "failed to generate process events: $(cat gen_$event.err)"
+	if [ $gen_rc -ne 0 ]; then
+		tst_brk TBROK "failed to execute event_generator"
 	fi
 
 	if [ $lis_rc -ne 0 ]; then
-		tst_brk TBROK "failed to execute the listener: $(cat lis_$event.err)"
+		tst_brk TBROK "failed to execute pec_listener"
 	fi
 
 	# The listener writes the same messages as the generator, but it can
@@ -104,7 +112,7 @@ test()
 
 	fd_act=$(free_fd)
 	[ -z "$fd_act" ] && tst_brk TBROK "No free filehandle found"
-	eval "exec ${fd_act}<lis_$event.log"
+	eval "exec ${fd_act}<lis.log"
 
 	failed=0
 	act_nevents=0
@@ -122,7 +130,7 @@ test()
 			tst_res TFAIL "Event was not detected by the event listener: $exp"
 			break
 		fi
-	done <gen_$event.log
+	done <gen.log
 
 	eval "exec ${fd_act}<&-"
 
@@ -134,7 +142,7 @@ test()
 		fi
 	else
 		# TFAIL message is already printed in the loop above
-		cat lis_$event.log
+		cat lis.log
 	fi
 }
 
diff --git a/testcases/kernel/connectors/pec/event_generator.c b/testcases/kernel/connectors/pec/event_generator.c
index 62e341268..722efec96 100644
--- a/testcases/kernel/connectors/pec/event_generator.c
+++ b/testcases/kernel/connectors/pec/event_generator.c
@@ -24,17 +24,16 @@ static struct tst_test test = {
 	.forks_child = 1
 };
 
-#define DEFAULT_EVENT_NUM       1
+static uid_t ltp_uid;
+static gid_t ltp_gid;
+static const char *ltp_user = "nobody";
+static char *prog_name;
 
-unsigned long nr_event = DEFAULT_EVENT_NUM;
+static int checkpoint_id = -1;
+static int nr_event = 1;
 
-uid_t ltp_uid;
-gid_t ltp_gid;
-const char *ltp_user = "nobody";
+static void (*gen_event)(void);
 
-char **exec_argv;
-
-void (*gen_event) (void);
 static void usage(int status) LTP_ATTRIBUTE_NORETURN;
 
 /*
@@ -47,45 +46,29 @@ static void usage(int status)
 	FILE *stream = (status ? stderr : stdout);
 
 	fprintf(stream,
-		"Usage: event_generator -e fork|exit|exec|uid|gid [-n nr_event]\n");
+		"Usage: event_generator -e fork|exit|exec|uid|gid [-n nr_event] [-c checkpoint_id]\n");
 
 	exit(status);
 }
 
 /*
  * Generate exec event.
- *
- * We can't just exec nr_event times, because the current process image
- * will be replaced with the new process image, so we use environment
- * variable as event counters, as it will be inherited after exec.
  */
 static void gen_exec(void)
 {
-	char *val;
 	char buf[10];
-	unsigned long nr_exec;
-
-	/* get the event counter */
-	val = getenv("NR_EXEC");
-	if (!val) {
-		nr_exec = 0;
-		setenv("NR_EXEC", "1", 1);
-	} else {
-		nr_exec = atoi(val);
-		snprintf(buf, 10, "%lu", nr_exec + 1);
-		setenv("NR_EXEC", buf, 1);
-	}
-
-	/* stop generate exec event */
-	if (nr_exec >= nr_event)
-		return;
 
 	/* fflush is needed before exec */
 	printf("exec pid: %d\n", getpid());
 	fflush(stdout);
 
-	/* Note: This expects the full path to self in exec_argv[0]! */
-	SAFE_EXECVP(exec_argv[0], exec_argv);
+	/*
+	 * Decrease number of events to generate.
+	 * Don't pass checkpoint_id here. It is only used for synchronizing with
+	 * the shell script, before the first exec.
+	 */
+	sprintf(buf, "%u", nr_event - 1);
+	SAFE_EXECLP(prog_name, prog_name, "-e", "exec", "-n", buf, NULL);
 }
 
 /*
@@ -135,9 +118,8 @@ static inline void gen_gid(void)
 static void process_options(int argc, char **argv)
 {
 	int c;
-	char *end;
 
-	while ((c = getopt(argc, argv, "e:n:h")) != -1) {
+	while ((c = getopt(argc, argv, "e:n:c:h")) != -1) {
 		switch (c) {
 			/* which event to generate */
 		case 'e':
@@ -158,17 +140,21 @@ static void process_options(int argc, char **argv)
 			break;
 			/* number of event to generate */
 		case 'n':
-			nr_event = strtoul(optarg, &end, 10);
-			if (*end != '\0' || nr_event == 0) {
-				fprintf(stderr, "wrong -n argument!");
-				exit(1);
+			if (tst_parse_int(optarg, &nr_event, 0, INT_MAX)) {
+				fprintf(stderr, "invalid value for nr_event");
+				usage(1);
+			}
+			break;
+		case 'c':
+			if (tst_parse_int(optarg, &checkpoint_id, 0, INT_MAX)) {
+				fprintf(stderr, "invalid value for checkpoint_id");
+				usage(1);
 			}
 			break;
 			/* help */
 		case 'h':
 			usage(0);
 		default:
-			fprintf(stderr, "unknown option!\n");
 			usage(1);
 		}
 	}
@@ -179,11 +165,14 @@ static void process_options(int argc, char **argv)
 	}
 }
 
+void *tst_futexes;
 int main(int argc, char **argv)
 {
-	unsigned long i;
+	int i;
 	struct passwd *ent;
 
+	prog_name = argv[0];
+
 	tst_test = &test;
 
 	process_options(argc, argv);
@@ -196,13 +185,21 @@ int main(int argc, char **argv)
 	ltp_uid = ent->pw_uid;
 	ltp_gid = ent->pw_gid;
 
-	/* special processing for gen_exec, see comments above gen_exec() */
-	if (gen_event == gen_exec) {
-		exec_argv = argv;
-
-		gen_exec();
+	/* ready to generate events */
+	if (checkpoint_id != -1) {
+		tst_reinit();
+		TST_CHECKPOINT_WAIT(checkpoint_id);
+	}
 
-		/* won't reach here */
+	if (gen_event == gen_exec) {
+		/*
+		 * The nr_event events are generated,
+		 * by recursively replacing ourself with
+		 * a fresh copy, decrementing the number of events
+		 * for each execution
+		 */
+		if (nr_event != 0)
+			gen_exec();
 		return 0;
 	}
 
@@ -225,6 +222,14 @@ int main(int argc, char **argv)
 				fprintf(stderr, "Child process did not terminate with 0\n");
 				return 1;
 			}
+			/*
+			 * We need a tiny sleep here, so the kernel can generate
+			 * exit events in the correct order.
+			 * Otherwise it can happen, that exit events are generated
+			 * out-of-order.
+			 */
+			if (gen_event == gen_exit)
+				usleep(100);
 		}
 	}
 
diff --git a/testcases/kernel/connectors/pec/pec_listener.c b/testcases/kernel/connectors/pec/pec_listener.c
index 2707ea8fb..21ae53e87 100644
--- a/testcases/kernel/connectors/pec/pec_listener.c
+++ b/testcases/kernel/connectors/pec/pec_listener.c
@@ -19,6 +19,9 @@
 #include <signal.h>
 #include <linux/types.h>
 #include <linux/netlink.h>
+#include <tst_checkpoint.h>
+#define TST_NO_DEFAULT_MAIN
+#include <tst_test.h>
 
 #ifndef NETLINK_CONNECTOR
 
@@ -52,9 +55,13 @@ static __u32 seq;
 
 static volatile int exit_flag;
 static struct sigaction sigint_action;
+static pid_t terminate_pid;
+static int checkpoint_id = -1;
 
 struct nlmsghdr *nlhdr;
 
+static void usage(int status) LTP_ATTRIBUTE_NORETURN;
+
 /*
  * Handler for signal int. Set exit flag.
  *
@@ -176,6 +183,7 @@ static void process_event(struct nlmsghdr *nlhdr)
 
 	pe = (struct proc_event *)msg->data;
 
+	//printf("TS: %llu\n", pe->timestamp_ns);
 	switch (pe->what) {
 	case PROC_EVENT_NONE:
 		printf("none err: %u\n", pe->event_data.ack.err);
@@ -203,6 +211,9 @@ static void process_event(struct nlmsghdr *nlhdr)
 		       pe->event_data.exit.process_pid,
 		       pe->event_data.exit.exit_code,
 		       pe->event_data.exit.exit_signal);
+			if (terminate_pid
+				&& terminate_pid == pe->event_data.exec.process_pid)
+				exit_flag = 1;
 		break;
 	default:
 		printf("unknown event\n");
@@ -210,7 +221,42 @@ static void process_event(struct nlmsghdr *nlhdr)
 	}
 }
 
-int main(void)
+static void usage(int status)
+{
+	FILE *stream = (status ? stderr : stdout);
+
+	fprintf(stream, "Usage: pec_listener [-p terminate_pid] [-c checkpoint_id]\n");
+
+	exit(status);
+}
+
+static void parse_args(int argc, char * const argv[])
+{
+	int c;
+
+	while ((c = getopt(argc, argv, "p:c:h")) != -1) {
+		switch (c) {
+		case 'p':
+			if (tst_parse_int(optarg, &terminate_pid, 0, INT_MAX)) {
+				fprintf(stderr, "Invalid value for terminate pid\n");
+				exit(1);
+			}
+			break;
+		case 'c':
+			if (tst_parse_int(optarg, &checkpoint_id, 0, INT_MAX)) {
+				fprintf(stderr, "invalid value for checkpoint_id");
+				usage(1);
+			}
+			break;
+		case 'h':
+			usage(0);
+		default:
+			usage(1);
+		}
+	}
+}
+
+int main(int argc, char * const argv[])
 {
 	int ret;
 	int sd;
@@ -218,6 +264,8 @@ int main(void)
 	struct sockaddr_nl src_addr;
 	struct pollfd pfd;
 
+	parse_args(argc, argv);
+
 	sigint_action.sa_flags = SA_RESETHAND;
 	sigint_action.sa_handler = &sigint_handler;
 	sigaction(SIGINT, &sigint_action, NULL);
@@ -257,6 +305,12 @@ int main(void)
 		exit(1);
 	}
 
+	/* ready to receive events */
+	if (checkpoint_id != -1) {
+		tst_reinit();
+		TST_CHECKPOINT_WAKE(0);
+	}
+
 	/* Receive msg from PEC */
 	pfd.fd = sd;
 	pfd.events = POLLIN;
-- 
2.25.1

