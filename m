From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 23 Dec 2020 16:57:26 +0800
Subject: [LTP] [PATCH 3/3] syscalls/ipc: semctl09: add a test for
 SEM_STAT_ANY
In-Reply-To: <1608626908-8117-3-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1608626908-8117-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <1608626908-8117-3-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <5FE30676.8060004@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Feiyu

> +#include<stdio.h>
> +#include<pwd.h>
> +#include<sys/sem.h>
> +#include "tst_test.h"
> +#include "tst_safe_sysv_ipc.h"
> +#include "libnewipc.h"
> +#include "lapi/semun.h"
> +#include "lapi/sem.h"
I doubt do we really need two lapi headers, maybe we can remove semun.h 
and remove union struct definition into lapi/sem.h.
> +#include "lapi/syscalls.h"
> +
> +static int sem_id = -1;
> +static uid_t nobody_uid, root_uid;
> +static union semun un;
> +
> +static inline int tst_sys_semctl(int semid, int semnum, int cmd)
> +{
> +	return tst_syscall(__NR_semctl, semid, semnum, cmd,&un.buf);
It looks like semctl man-pages has wrong description. We should use 
sem_ds struct instead of seminfo struct. I have sent a patch[1] to 
man-pages community.

[1]https://github.com/linux-mailinglist-archives/linux-man.vger.kernel.org.0/commit/f2bda64c45a38ba7c895716908321f34ddd25cdc
> +}
> +
> +static inline int tst_semctl(int semid, int semnum, int cmd)
> +{
> +	return semctl(semid, semnum, cmd,&un.buf);
> +}
> +
Since we test glibc and syscall,  I think we should use test_variants 
like semop case.
> +static struct tcases {
> +	uid_t *uid;
> +	int (*test_semctl) ();
> +	char *desc;
> +} tests[] = {
> +	{&nobody_uid, tst_sys_semctl, "with nobody user by syscall()",},
> +	{&nobody_uid, tst_semctl, "with nobody user",},
> +	{&root_uid, tst_sys_semctl, "with root user by syscall()",},
> +	{&root_uid, tst_semctl, "with root user",}
> +};
> +
> +static void parse_proc_sysvipc(struct seminfo *info)
> +{
> +	FILE *f = fopen("/proc/sysvipc/sem", "r");
> +	int semset_cnt = 0;
> +	int sem_cnt = 0;
> +
> +	/* Eat header */
> +	for (;;) {
> +		int c = fgetc(f);
> +
> +		if (c == '\n' || c == EOF)
> +			break;
> +	}
> +
> +	int nsems;
> +	/*
> +	 * Sum sem set, nsems for all elements listed, which should equal
> +	 * the data returned in the seminfo structure.
> +	 */
> +	while (fscanf(f, "%*i %*i %*i %i %*i %*i %*i %*i %*i %*i",
> +		&nsems)>  0){
> +		semset_cnt++;
> +		sem_cnt += nsems;
> +	}
> +
> +	if (info->semusz != semset_cnt) {
> +		tst_res(TFAIL, "semusz = %i, expected %i",
> +				info->semusz, semset_cnt);
> +	} else {
> +		tst_res(TPASS, "semset_cnt = %i", semset_cnt);
> +	}
> +
> +	if (info->semaem != sem_cnt) {
> +		tst_res(TFAIL, "semaem = %i, expected %i",
> +				info->semaem, sem_cnt);
> +	} else {
> +		tst_res(TPASS, "sen_cnt = %i", sem_cnt);
> +	}
> +
> +	fclose(f);
> +}
> +
> +static void verify_semctl(unsigned int n)
> +{
> +	struct tcases *tc =&tests[n];
> +	int i, semid, cnt = 0;
> +	struct seminfo info;
> +	union semun arg;
> +
> +	tst_res(TINFO, "Test SEM_STAT_ANY %s", tc->desc);
> +
> +	SAFE_SETEUID(*tc->uid);
> +
> +	arg.__buf =&info;
> +
> +	TEST(semctl(sem_id, 0, SEM_INFO, arg));
> +
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "semctl(sem_id, 0, SEM_INFO, ...)");
> +		return;
> +	}
> +
> +	semid = (*tc->test_semctl) (TST_RET, 0, SEM_STAT_ANY);
> +
> +	if (errno == EFAULT) {
> +		tst_res(TFAIL, "SEM_STAT_ANY doesn't pass the buffer "
> +				"specified by the caller to kernel");
> +		return;
> +	} else if (semid == -1) {
> +		tst_res(TFAIL | TTERRNO, "SEM_INFO haven't returned a valid index");
> +	} else {
> +		tst_res(TPASS, "SEM_INFO returned valid index %li to semid %i",
> +			TST_RET, semid);
> +	}
> +
> +	for (i = 0; i<= TST_RET; i++) {
> +		if (((*tc->test_semctl) (i, 0, SEM_STAT_ANY)) != -1)
> +			cnt++;
> +	}
> +
> +	if (cnt == info.semusz) {
> +		tst_res(TPASS, "Counted used = %i", cnt);
> +	} else {
> +		tst_res(TFAIL, "Counted used = %i, semuse = %i",
> +			cnt, info.semusz);
> +	}
> +
> +	parse_proc_sysvipc(&info);
> +}
> +
> +static void setup(void)
> +{
> +	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
> +	nobody_uid = ltpuser->pw_uid;
> +	root_uid = 0;
> +
> +	sem_id = SAFE_SEMGET(IPC_PRIVATE, 2, IPC_CREAT | 0600);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (sem_id>= 0)
> +		SAFE_SEMCTL(sem_id, 0, IPC_RMID);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test = verify_semctl,
> +	.tcnt = ARRAY_SIZE(tests),
> +	.needs_root = 1,
> +};



