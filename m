From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 13 Feb 2018 14:12:36 +0100
Subject: [LTP] [PATCH v2] Add read_all file systems test
In-Reply-To: <20180122132123.GA10527@rei.lan>
References: <20180119163715.32599-1-rpalethorpe@suse.com>
 <20180122132123.GA10527@rei.lan>
Message-ID: <87mv0dxccb.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis writes:

> Hi!
>> +#define QUEUE_SIZE 16384
>> +#define BUFFER_SIZE 1024
>> +#define MAX_PATH 4096
>> +#define MAX_DISPLAY 40
>> +
>> +struct queue {
>> +	sem_t sem;
>> +	int front;
>> +	int back;
>> +	char data[QUEUE_SIZE];
>> +};
>> +
>> +struct worker {
>> +	pid_t pid;
>> +	struct queue *q;
>> +};
>> +
>> +enum dent_action {
>> +	DA_UNKNOWN,
>> +	DA_IGNORE,
>> +	DA_READ,
>> +	DA_VISIT,
>> +};
>> +
>> +static char *verbose;
>> +static char *quite;
>                   ^
> 		quiet?
>
>> +static char *root_dir;
>> +static char *exclude;
>> +static char *str_repeat;
>> +static int repeat = 1;
>> +static long worker_count;
>> +static struct worker *workers;
>> +
>> +static struct tst_option options[] = {
>> +	{"v", &verbose,
>> +	 "-v       Print information about successful reads"},
>> +	{"q", &quite,
>> +	 "-q       Don't print file read or open errors"},
>> +	{"d:", &root_dir,
>> +	 "-d path  Path to the directory to read from, defaults to /sys"},
>> +	{"e:", &exclude,
>> +	 "-e pattern Ignore files which match an 'extended' pattern, see fnmatch(3)"},
>> +	{"r:", &str_repeat,
>> +	 "-r count The number of times to schedule a file for reading"},
>
> I'm not sure repeat is the right name for parameter, I do not have much
> better idea though, maybe iteration.
>
>> +	{NULL, NULL, NULL}
>> +};
>> +
>> +static int queue_pop(struct queue *q, char *buf)
>> +{
>> +	int i = q->front, j = 0;
>> +
>> +	sem_wait(&q->sem);
>> +
>> +	if (!q->data[i])
>> +		return 0;
>> +
>> +	while (q->data[i]) {
>> +		buf[j] = q->data[i];
>> +
>> +		if (++j >= BUFFER_SIZE - 1)
>> +			tst_brk(TBROK, "Buffer is too small for path");
>> +		if (++i >= QUEUE_SIZE)
>> +			i = 0;
>> +	}
>> +
>> +	buf[j] = '\0';
>> +	tst_atomic_store(i + 1, &q->front);
>> +
>> +	return 1;
>> +}
>> +
>> +static int queue_push(struct queue *q, const char *buf)
>> +{
>> +	int i = q->back, j = 0;
>> +	int front = tst_atomic_load(&q->front);
>> +
>> +	while (buf[j]) {
>> +		q->data[i] = buf[j];
>> +
>> +		++j;
>> +		if (++i >= QUEUE_SIZE)
>> +			i = 0;
>> +		if (i == front)
>> +			return 0;
>> +	}
>> +	q->data[i] = '\0';
>> +
>> +	q->back = i + 1;
>> +	sem_post(&q->sem);
>> +
>> +	return 1;
>> +}
>> +
>> +static struct queue *queue_init(void)
>> +{
>> +	struct queue *q = SAFE_MMAP(NULL, sizeof(*q),
>> +				    PROT_READ | PROT_WRITE,
>> +				    MAP_SHARED | MAP_ANONYMOUS,
>> +				    0, 0);
>> +
>> +	sem_init(&q->sem, 1, 0);
>> +	q->front = 0;
>> +	q->back = 0;
>> +
>> +	return q;
>> +}
>> +
>> +static void queue_destroy(struct queue *q, int is_worker)
>> +{
>> +	if (is_worker)
>> +		sem_destroy(&q->sem);
>> +
>> +	SAFE_MUNMAP(q, sizeof(*q));
>> +}
>> +
>> +static void sanitize_str(char *buf, ssize_t count)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < MIN(count, MAX_DISPLAY); i++)
>> +		if (!isprint(buf[i]))
>> +			buf[i] = ' ';
>> +
>> +	if (count <= MAX_DISPLAY)
>> +		buf[count] = '\0';
>> +	else
>> +		strcpy(buf + MAX_DISPLAY, "...");
>> +}
>> +
>> +static void read_test(const char *path)
>> +{
>> +	char buf[BUFFER_SIZE];
>> +	int fd;
>> +	ssize_t count;
>> +
>> +	if (exclude && !fnmatch(exclude, path, FNM_EXTMATCH)) {
>> +		if (verbose)
>> +			tst_res(TINFO, "Ignoring %s", path);
>> +		return;
>> +	}
>> +
>> +	if (verbose)
>> +		tst_res(TINFO, "%s(%s)", __func__, path);
>> +
>> +	fd = open(path, O_RDONLY | O_NONBLOCK);
>> +	if (fd < 0 && !quite) {
>> +		tst_res(TINFO | TERRNO, "open(%s)", path);
>> +		return;
>> +	} else if (fd < 0)
>> +		return;
>
> I guess that this would be a bit more readable:
>
>
> 	if (fd < 0) {
> 		if (!quiet)
> 			tst_res(...)
> 		return;
> 	}
>
>> +	count = read(fd, buf, sizeof(buf) - 1);
>> +	if (count > 0 && verbose) {
>> +		sanitize_str(buf, count);
>> +		tst_res(TINFO, "read(%s, buf) = %ld, buf = %s",
>> +			path, count, buf);
>> +	} else if (!count && verbose)
>> +		tst_res(TINFO, "read(%s) = EOF", path);
>> +
>> +	else if (count < 0 && !quite)
>> +		tst_res(TINFO | TERRNO, "read(%s)", path);
>> +
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +static int worker_run(struct worker *self)
>> +{
>> +	int ret;
>> +	char buf[BUFFER_SIZE];
>> +	struct sigaction term_sa = {
>> +		.sa_handler = SIG_IGN,
>> +		.sa_flags = 0,
>> +	};
>> +	struct queue *q = self->q;
>> +
>> +	sigaction(SIGTTIN, &term_sa, NULL);
>> +
>> +	for (ret = queue_pop(q, buf); ret; ret = queue_pop(q, buf))
>> +		read_test(buf);
>
> As much as I do like to strech for loop for everything this would be
> probably more elegant as an infinite loop with a break.
>
> 	for (;;) {
> 		if (!queue_pop(q, buf))
> 			break;
>
> 		read_test(buf);
> 	}
>
>> +	queue_destroy(q, 1);
>> +	fflush(stdout);
>
> What are trying to flush here? The tst_res() messages are printed
> into the stderr btw.

I found that the pass message was being written after some of the
childrens' information messages. Calling fflush on stdout prevents that
from happening even though it is the wrong fd...

I have changed it to stderr, which seems more correct.

>
>> +	return 0;
>> +}
>> +
>> +static void spawn_workers(void)
>> +{
>> +	int i;
>> +	struct worker *wa = workers;
>> +
>> +	bzero(workers, worker_count * sizeof(*workers));
>> +
>> +	for (i = 0; i < worker_count; i++) {
>> +		wa[i].q = queue_init();
>> +		wa[i].pid = SAFE_FORK();
>> +		if (!wa[i].pid)
>> +			exit(worker_run(wa + i));
>> +	}
>> +}
>> +
>> +static void stop_workers(void)
>> +{
>> +	const char stop_code[1] = { '\0' };
>> +	int i;
>> +
>> +	if (!workers)
>> +		return;
>> +
>> +	for (i = 0; i < worker_count; i++)
>> +		if (workers[i].q)
>> +			queue_push(workers[i].q, stop_code);
>> +
>> +	for (i = 0; i < worker_count; i++)
>> +		if (workers[i].q) {
>> +			queue_destroy(workers[i].q, 0);
>> +			workers[i].q = 0;
>> +		}
>
> FYI LKML coding style preferes curly braces around the block in a case
> that it spans over multiple lines.
>
>> +}
>> +
>> +static void sched_work(const char *path)
>> +{
>> +	static int cur;
>> +	int push_attempts = 0, pushed;
>> +
>> +	while (1) {
>> +		pushed = queue_push(workers[cur].q, path);
>> +
>> +		if (++cur >= worker_count)
>> +			cur = 0;
>> +
>> +		if (pushed)
>> +			break;
>> +
>> +		if (++push_attempts > worker_count) {
>> +			usleep(100);
>> +			push_attempts = 0;
>> +		}
>> +	}
>> +}
>> +
>> +static void rep_sched_work(const char *path, int rep)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < rep; i++)
>> +		sched_work(path);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	if (tst_parse_int(str_repeat, &repeat, 1, INT_MAX))
>> +		tst_brk(TBROK,
>> +			"Invalid repeat (-r) argument: '%s'", str_repeat);
>
>> +	if (!root_dir)
>> +		tst_brk(TBROK, "The directory argument (-d) is required");
>> +
>> +	worker_count = MIN(MAX(SAFE_SYSCONF(_SC_NPROCESSORS_ONLN) - 1, 1), 15);
>
> We do have tst_ncpus() because there are older distros that do not
> define the _SC_* macros, please use that one instead here.
>
> Also we cap the number of workers on 15 here, shouldn't that be at least
> macro constant? I also wonder if we should supply command line option to
> override the number of workers.
>
>> +	workers = SAFE_MALLOC(worker_count * sizeof(*workers));
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	stop_workers();
>
> We are stopping the workers at the end of the run(), do we really need
> to stop them here as well?

spawn_workers calls SAFE_FORK which could fail after a few workers have
already been spawned.

>
>> +	free(workers);
>> +}
>> +
>> +static void visit_dir(const char *path)
>> +{
>> +	DIR *dir;
>> +	struct dirent *dent;
>> +	struct stat dent_st;
>> +	char dent_path[MAX_PATH];
>> +	enum dent_action act;
>> +
>> +	dir = opendir(path);
>> +	if (!dir) {
>> +		tst_res(TINFO | TERRNO, "opendir(%s)", path);
>> +		return;
>> +	}
>> +
>> +	while (1) {
>> +		errno = 0;
>> +		dent = readdir(dir);
>> +		if (!dent && errno) {
>> +			tst_res(TINFO | TERRNO, "readdir(%s)", path);
>> +			break;
>> +		} else if (!dent)
>> +			break;
>> +
>> +		if (!strcmp(dent->d_name, ".") ||
>> +		    !strcmp(dent->d_name, ".."))
>> +			continue;
>> +
>> +		if (dent->d_type == DT_DIR)
>> +			act = DA_VISIT;
>> +		else if (dent->d_type == DT_LNK)
>> +			act = DA_IGNORE;
>> +		else if (dent->d_type == DT_UNKNOWN)
>> +			act = DA_UNKNOWN;
>> +		else
>> +			act = DA_READ;
>> +
>> +		snprintf(dent_path, MAX_PATH,
>> +			 "%s/%s", path, dent->d_name);
>> +
>> +		if (act == DA_UNKNOWN) {
>> +			if (lstat(dent_path, &dent_st))
>> +				tst_res(TINFO | TERRNO, "lstat(%s)", path);
>> +			else if ((dent_st.st_mode & S_IFMT) == S_IFDIR)
>> +				act = DA_VISIT;
>> +			else if ((dent_st.st_mode & S_IFMT) == S_IFLNK)
>> +				act = DA_IGNORE;
>> +			else
>> +				act = DA_READ;
>> +		}
>> +
>> +		if (act == DA_VISIT)
>> +			visit_dir(dent_path);
>> +		else if (act == DA_READ)
>> +			rep_sched_work(dent_path, repeat);
>> +	}
>> +
>> +	if (closedir(dir))
>> +		tst_res(TINFO | TERRNO, "closedir(%s)", path);
>> +}
>> +
>> +static void run(void)
>> +{
>> +	spawn_workers();
>> +	visit_dir(root_dir);
>> +	stop_workers();
>> +
>> +	tst_reap_children();
>> +	tst_res(TPASS, "Finished reading files");
>> +}
>> +
>> +static struct tst_test test = {
>> +	.options = options,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test_all = run,
>> +	.forks_child = 1,
>> +};
>
> The rest looks good to me.


-- 
Thank you,
Richard.
