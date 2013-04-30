Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UX9az-0002r7-QM
	for ltp-list@lists.sourceforge.net; Tue, 30 Apr 2013 12:23:45 +0000
Date: Tue, 30 Apr 2013 14:24:39 +0200
From: chrubis@suse.cz
Message-ID: <20130430122439.GA1367@rei>
References: <1367303231-7061-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1367303231-7061-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] New core test of hardlinks and symlinks
 restrictions added in Linux 3.6. Disabled by default in Linux 3.7.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/security/prot_hsymlinks/.gitignore b/testcases/kernel/security/prot_hsymlinks/.gitignore
> new file mode 100644
> index 0000000..68e41da
> --- /dev/null
> +++ b/testcases/kernel/security/prot_hsymlinks/.gitignore
> @@ -0,0 +1 @@
> +/prot_hsymlinks
> diff --git a/testcases/kernel/security/prot_hsymlinks/Makefile b/testcases/kernel/security/prot_hsymlinks/Makefile
> new file mode 100644
> index 0000000..80b91fe
> --- /dev/null
> +++ b/testcases/kernel/security/prot_hsymlinks/Makefile
> @@ -0,0 +1,71 @@
> +# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA 
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk

The very first include in the Makefile must be the env_pre.mk

> +####### Tools and options
> +DEFINES			=
> +INCPATH			= -I. -I/usr/include
> +LINK			= $(CC)
> +MKDIR			= mkdir -p
> +RM_DIR			= rmdir
> +RM_FILE			= rm -f
> +CHK_DIR_EXISTS	= test -d
> +
> +####### Files
> +
> +SOURCES	= 	hs_main.c \
> +		options.c \
> +		exec_cmd.c \
> +		hs_test.c \
> +		cleanup.c \
> +		wrp_links.c \
> +		wrp_users.c
> +
> +OBJECTS	= 	hs_main.o \
> +		options.o \
> +		exec_cmd.o \
> +		hs_test.o \
> +		cleanup.o \
> +		wrp_links.o \
> +		wrp_users.o
> +
> +TARGET_NAME 		= prot_hsymlinks
> +MAKE_TARGETS		:=$(TARGET_NAME)
> +
> +first: all
> +
> +####### Build rules
> +
> +all: Makefile $(MAKE_TARGETS)
> +
> +FILTER_OUT_MAKE_TARGETS		:= hs_test cleanup exec_cmd options wrp_links wrp_users
> +
> +$(MAKE_TARGETS):  $(OBJECTS)
> +	$(LINK) $(LDFLAGS) -o $(MAKE_TARGETS) $(OBJECTS) $(LIBS) $(LDLIBS)
> +	@$(RM_FILE) $(OBJECTS)

Do not use adhoc rules like this, use the LTP buildsystem.

> +####### Compile
> +
> +INSTALL_TARGETS	:=	$(MAKE_TARGETS)
> +
> +CLEAN_TARGETS	+=	$(MAKE_TARGETS).tar.gz
> +
> +pack:
> +	tar -cvzf $(TARGET_NAME).tar.gz $(TARGET_NAME)
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk

> diff --git a/testcases/kernel/security/prot_hsymlinks/README b/testcases/kernel/security/prot_hsymlinks/README
> new file mode 100644
> index 0000000..860e2c0
> --- /dev/null
> +++ b/testcases/kernel/security/prot_hsymlinks/README
> @@ -0,0 +1,64 @@
> +TEST SUITE:
> +
> +The directory prot_hsymlinks contains the tests related to harlinks and
> +symlinks restrictions.
> +
> +TESTS AIM:
> +
> +The aim of the tests is to check the restrictions
> +for hardlinks and symlinks:
> +
> +This security restrictions were added in Linux 3.6 and enabled by default,
> +but it broke some programs. It has been disabled by default in Linux 3.7 and
> +to control it special proc parameters added. Distributions and users can enable it by writing "1"
> +to /proc/sys/fs/protected_symlinks and /proc/sys/fs/protected_hardlinks.
> +
> +This test enables restrictions and check following preconditions.
> +Symlinks restriction applies only to privileged users (other
> +combinations of non-privileged user, sticky bit and world-writable
> +dirs are not affected). Only privileged user can't follow symlinks
> +in only sticky world-writable directory if he isn't owner of that link.
> +All other users can.
> +
> +Hard links restriction applies only to non-privileged users. Only
> +non-privileged user can't create hard links to files if he isn't owner
> +of the file or he doesn't have write access to the file despite of file's
> +directory permission.
> +
> +FILES DESCRIPTION:
> +
> +hs_main.c
> +----------
> +Test main entry point.
> +
> +hs_test.c
> +----------
> +This file contains tests implementation.
> +
> +cleanup.c
> +---------------
> +This file contains cleanup functions and linked list structure.
> +
> +exec_cmd.c
> +---------------
> +Implements execution of some other programs in the test.
> +
> +options.c
> +----------
> +Implements program options.
> +
> +wrp_links.c
> +----------
> +Implements functions to deal with hard and symbolic links.
> +
> +wrp_users.c
> +----------
> +Wrapper to change effective group and user id.
> +
> +Makefile
> +--------
> +The makefile for this test.
> +
> +README:
> +--------
> +This file.
        ^
Don't describe the obvious.


For the rest of the code, please use LKML coding style and
checkpatch.pl before sumbitting.

> diff --git a/testcases/kernel/security/prot_hsymlinks/cleanup.c b/testcases/kernel/security/prot_hsymlinks/cleanup.c
> new file mode 100644
> index 0000000..db0c862
> --- /dev/null
> +++ b/testcases/kernel/security/prot_hsymlinks/cleanup.c
> @@ -0,0 +1,118 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author:
> + * Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + * File: cleanup.c
       ^
Again, this is obvious

> + * This file contains cleanup functions and linked list structure
> + *
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +/* LTP includes */
        ^
Avoid comments like this.

> +#include <test.h>
> +#include <safe_macros.h>
> +#include <usctest.h>
> +
> +#include "cleanup.h"
> +
> +int _skip_cleanup;
> +
> +int _root_cleanup;

Never use variables starting with underscore, these are reserved for the
compiler/libc implementation. In this case they should be declared
static.

> +/* cleanup linked-list, contains cleanup functions */
> +struct cleanup_list {
> +	void (*cleanup_fun)(void);
> +	struct cleanup_list *prev;
> +	struct cleanup_list *next;
> +};
> +
> +/* head of list */
> +struct cleanup_list* clean_list_head;
> +
> +/* current position */
> +struct cleanup_list* clean_list;

Again, don't comment the obvious. The variables either are, or should be
named decriptive enough.

> +void cleanup_init(void)
> +{
> +	_skip_cleanup = 0;
> +	_root_cleanup = 1;
> +	clean_list_head=NULL;
> +	clean_list=NULL;
> +}

This function should not exist. Instead you should initialize the
root_cleanup to 1 (the rest is initialized to 0).

> +void cleanup_add( void (*cleanup_fun)(void) )
> +{
> +	
> +	if(clean_list_head==NULL) {
> +		/* first time */
> +		clean_list_head = (struct cleanup_list*)SAFE_MALLOC(NULL,
> +					sizeof(struct cleanup_list));

The cast to struct clenaup_list is not needed here.

> +		clean_list = clean_list_head;
> +		clean_list->prev = NULL;
> +	} else {
> +		clean_list->next = (struct cleanup_list*)SAFE_MALLOC(NULL,
> +					sizeof(struct cleanup_list));
> +		(clean_list->next)->prev = clean_list;
> +		clean_list = clean_list->next;
> +	}
> +	
> +	clean_list->cleanup_fun = cleanup_fun;
> +	clean_list->next = NULL;
> +
> +}
> +
> +void cleanup(void)
> +{
> +	/* call cleanup function only once */
> +	static int first_call = 1;
> +	if(!first_call) return;
> +	first_call = 0;
> +	
> +	if(_root_cleanup) {
> +		SAFE_SETEGID(NULL,0);
> +		SAFE_SETEUID(NULL,0);
> +	}
> +		
> +	struct cleanup_list* lst = clean_list;
> +	
> +	/* call every cleanup functions passed
> +	 * in reverse order 
> +	 */
> +	if(!_skip_cleanup)
> +		while(lst) {
> +			lst->cleanup_fun();
> +			lst = lst->prev;
> +		}

LKML preffers curly braces around multiline block, even it is not hard
rule.

> +	lst = clean_list_head;
> +	struct cleanup_list *new_list = clean_list;
> +
> +	/* free the list */
> +	while(new_list) {
> +		
> +		new_list = lst->prev;
> +		free(lst);
> +		lst=new_list;
> +	}
> +	
> +	tst_rmdir();
> +	TEST_CLEANUP;
> +}

Moreover I do not like the whole idea of allocated list of cleanup
function pointers. Just having a few flags that are set by the setup and
used by the cleaup should be just enough.

Something like:

static int foo_initialized;


static void setup(void)
{
 ...

	if (init_foo()) {
		//ERROR
	}

	foo_initialied = 1;
}

static int cleanup(void)
{
...

	if (foo_initialized) {
		destroy_foo();
	}
}

Even better you should do ALL the setup in the setup(), then there is no
need for the global flags.


> diff --git a/testcases/kernel/security/prot_hsymlinks/cleanup.h b/testcases/kernel/security/prot_hsymlinks/cleanup.h
> new file mode 100644
> index 0000000..f63fa2b
> --- /dev/null
> +++ b/testcases/kernel/security/prot_hsymlinks/cleanup.h
> @@ -0,0 +1,51 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author:
> + * Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + * File: cleanup.h
> + *
> + * This file contains cleanup functions and linked list structure
> + *
> + */
> +
> +#ifndef CLEANUP_FILE_H
> +#define CLEANUP_FILE_H
> +
> +/*
> + * flag to skip cleanup
> + */
> +extern int _skip_cleanup;
> +
> +/*
> + * set root user for cleanup
> + * 1 - cleanup as root (default)
> + * 0 - cleanup as current user
> + */
> +extern int _root_cleanup;

You are actually exporting these as a API, this is way to ugly.

> +/*
> + * have to call it befor any use of cleanup
> + */
> +extern void cleanup_init(void);
> +
> +extern void cleanup(void);
> +
> +/* pass pointer of cleanup function, it'll be added to cleanup list */
> +extern void cleanup_add( void (*cleanup_fun)(void) );
> +
> +#endif /* CLEANUP_FILE_H */
> diff --git a/testcases/kernel/security/prot_hsymlinks/exec_cmd.c b/testcases/kernel/security/prot_hsymlinks/exec_cmd.c
> new file mode 100644
> index 0000000..8130567
> --- /dev/null
> +++ b/testcases/kernel/security/prot_hsymlinks/exec_cmd.c
> @@ -0,0 +1,69 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author:
> + * Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + * File: exec_cmd.c
> + *
> + * Implements execution of some other programs in the test.
> + */
> +
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +
> +#include <string.h>
> +#include <errno.h>
> +#include <sys/wait.h>
> +
> +/* LTP include */
> +#include <test.h>
> +
> +#include "exec_cmd.h"
> +
> +void exec_cmd(	void (*cleanup_fn)(void),
> +		const char* name, char* arg_list[],
> +		char* env[])
> +{
> +	/* clone the process */
> +	pid_t pid = vfork();
> +
> +	if(pid==-1) {
> +		tst_brkm(TBROK,cleanup_fn,"Failed to fork, error: %s",
> +			strerror(errno));
> +	}
> +	
> +	if(!pid) {
> +		/* child process code */
> +		if(env==NULL)
> +			_exit( execvp(name,arg_list) );
> +		else
> +			_exit( execve(name,arg_list,env) );

Why _exit(), is this code executed from within signal handler? If so,
the rest of the code is not signal-async-safe anyway.

> +	}
> +	
> +
> +	/* Wait and get the child process status */
> +	int child_status;
> +	child_status = 0;
> +	wait (&child_status);
> +
> +	if (child_status!=0)
> +		tst_brkm(TBROK,cleanup_fn,"the child process exited abnormally");
> +}
> diff --git a/testcases/kernel/security/prot_hsymlinks/exec_cmd.h b/testcases/kernel/security/prot_hsymlinks/exec_cmd.h
> new file mode 100644
> index 0000000..b21b1fe
> --- /dev/null
> +++ b/testcases/kernel/security/prot_hsymlinks/exec_cmd.h
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author:
> + * Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + * File: exec_cmd.h
> + *
> + * Implements execution of some other programs in the test.
> + */
> +
> +#ifndef EXEC_CMD_FILE_H
> +#define EXEC_CMD_FILE_H
> +
> +/* exec program
> + * @param cleanup function
> + * @param name program name 
> + * @param arg_list argument list
> + */
> +extern void exec_cmd(	void (*cleanup_fn)(void),
> +			const char* name, char* arg_list[],
> +			char* env[]);
> +
> +#endif /* EXEC_CMD_FILE_H */
> diff --git a/testcases/kernel/security/prot_hsymlinks/hs_main.c b/testcases/kernel/security/prot_hsymlinks/hs_main.c
> new file mode 100644
> index 0000000..7afa743
> --- /dev/null
> +++ b/testcases/kernel/security/prot_hsymlinks/hs_main.c
> @@ -0,0 +1,210 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author:
> + * Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + * File: main.c
> + *
> + * Test checks following preconditions:
> + *
> + * Symlinks restriction applies only to privileged users (other
> + * combinations of non-privileged user, sticky bit and world-writable
> + * dirs are not affected). Only privileged user can't follow symlinks in 
> + * only sticky world-writable directory if he isn't owner of that link. 
> + * All other users can.
> + *
> + * Hard links restriction applies only to non-privileged users. Only 
> + * non-privileged user can't create hard links to files if he isn't owner 
> + * of the file or he doesn't have write access to the file despite of 
> + * file's directory permission.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <signal.h>
> +
> +/* LTP Port */
> +#include <test.h>
> +#include <usctest.h>
> +
> +#include "options.h"	/* program options */
> +#include "hs_test.h"	/* hard & symlinks tests */
> +#include "cleanup.h"
> +#include "exec_cmd.h"
> +
> +char* TCID="prot_hsymlinks";
> +int TST_TOTAL=396;
> +
> +static void setup(int argc, char **argv);
> +
> +/* cleanup function */
> +void delete_test_user(void);
> +
> +/* cleanup functions 
> + * disable protected mode in kernel
> + */
> +void disable_protected_slinks(void);
> +void disable_protected_hlinks(void);
> +
> +/* 
> + * changes links restrictions 
> + * @param value can be:
> + * 0 - restrictions is off
> + * 1 - restrictions is on
> + */
> +void switch_protected_slinks(int value);
> +void switch_protected_hlinks(int value);
> +
> +int get_protected_slinks(void);
> +int get_protected_hlinks(void);
> +
> +static const char*  hardlink_protected_path 	= "/proc/sys/fs/protected_hardlinks";
> +static const char*  symlink_protected_path	= "/proc/sys/fs/protected_symlinks";
> +
> +int main(int argc, char **argv)
> +{	
> +	/* test setup */
> +	setup(argc,argv);
> +
> +	/* run all tests */
> +	hs_test_run();
> +
> +	/* cleanup and exit */
> +	cleanup();
> +	tst_exit();
> +}
> +
> +void setup(int argc, char **argv)
> +{
> +	cleanup_init();
> +	
> +	/* Deal with any options specified */
> +	init_options(argc,argv);
> +
> +	tst_require_root(NULL);
> +
> +	if(tst_kvercmp(3,7,0)<0)
> +		tst_brkm(TCONF,&cleanup,"Test must be run with kernel 3.7 or newer"); 
> +
> +	/* setup default signal handler */
> +	tst_sig(FORK,DEF_HANDLER,&cleanup);
> +
> +	/* create new user */
> +	char *useradd_argv[] = {
> +		"useradd",
> +		_users[TEST_USER],
> +		NULL,
> +	};
> +		
> +	exec_cmd(&cleanup,"useradd",useradd_argv,NULL);
> +
> +	/* 1st use hear */
> +	cleanup_add( &delete_test_user );
> +	
> +
> +	/* enable hard and symlinks restriction, it's not defualt
> +	 * but have to check
> +	 */
> +	if(!get_protected_hlinks()) {
> +	    switch_protected_hlinks(1);
> +	    cleanup_add(&disable_protected_hlinks);
> +	}
> +	if(!get_protected_slinks()) {
> +	    switch_protected_slinks(1);
> +	    cleanup_add(&disable_protected_slinks);
> +	}
> +	
> +	/* init the restriction test */
> +	hs_test_init();	
> +}
> +
> +void disable_protected_hlinks(void)
> +{
> +	tst_resm(TINFO,"Disable protected hardlinks mode back");
> +	switch_protected_hlinks(0);
> +}
> +void disable_protected_slinks(void)
> +{
> +	tst_resm(TINFO,"Disable protected symlinks mode back");
> +	switch_protected_slinks(0);
> +}
> +
> +int get_protected_hlinks(void)
> +{
> +	FILE* fd;
> +	fd = fopen(hardlink_protected_path,"r");
> +	if(fd==NULL)
> +	    tst_brkm(TBROK,&cleanup,"Can't read %s",hardlink_protected_path);
> +
> +	int value=0;
> +	fscanf(fd,"%d",&value);
> +	fclose(fd);
> +	return value;

Use SAFE_FILE_SCANF()

> +}
> +
> +int get_protected_slinks(void)
> +{
> +	FILE* fd;
> +	fd = fopen(symlink_protected_path,"r");
> +	if(fd==NULL)
> +	    tst_brkm(TBROK,&cleanup,"Can't read %s",symlink_protected_path);
> +
> +	int value=0;
> +	fscanf(fd,"%d",&value);
> +	fclose(fd);
> +	return value;
> +}

Here as well.

> +void switch_protected_hlinks(int value)
> +{
> +	FILE* fd;
> +	fd = fopen(hardlink_protected_path,"w");
> +	if(fd==NULL)
> +		tst_brkm(TBROK,&cleanup,"Can't set %d to %s",value,
> +			hardlink_protected_path);
> +
> +	fprintf(fd,"%d",value==1);
> +	fclose(fd);
> +}

Use SAFE_FILE_PRINTF()

> +void switch_protected_slinks(int value)
> +{
> +	FILE* fd = fopen(symlink_protected_path,"w");
> +	if(fd==NULL)
> +		tst_brkm(TBROK,&cleanup,"Can't set %d to %s",value,
> +			symlink_protected_path);
> +
> +	fprintf(fd,"%d",value==1);
> +	fclose(fd);
> +}

Here as well.

> +void delete_test_user(void)
> +{
> +	/* create new user */
> +	
> +	tst_resm(TINFO,"Delete test user: %s",_users[TEST_USER]);
> +
> +	
> +	char *userdel_argv[] = {
> +		"userdel",
> +		"-r",
> +		_users[TEST_USER],
> +		NULL,
> +	};
> +	
> +	exec_cmd(&cleanup,"userdel",userdel_argv,NULL);

Is there any reason why this couldn't be just call to system() with
preassembled string? There is NO need to create your own exec_cmd().

> +}
> diff --git a/testcases/kernel/security/prot_hsymlinks/hs_test.c b/testcases/kernel/security/prot_hsymlinks/hs_test.c
> new file mode 100644
> index 0000000..02178b4
> --- /dev/null
> +++ b/testcases/kernel/security/prot_hsymlinks/hs_test.c
> @@ -0,0 +1,515 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author:
> + * Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + * File: hs_test.c
> + *
> + * Test implementation
> + * -------------------
> + * Symlinks restriction applies only to privileged users (other
> + * combinations of non-privileged user, sticky bit and world-writable
> + * dirs are not affected). Only privileged user can't follow symlinks in 
> + * only sticky world-writable directory if he isn't owner of that link. 
> + * All other users can.
> + *
> + * Hard links restriction applies only to non-privileged users. Only 
> + * non-privileged user can't create hard links to files if he isn't owner 
> + * of the file or he doesn't have write access to the file despite of 
> + * file's directory permission.
> + */
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <time.h>
> +
> +/* LTP include */
> +#include <test.h>
> +#include <safe_macros.h>
> +
> +#include "options.h"
> +#include "wrp_links.h"	/* hard & symlinks wrappers */
> +#include "wrp_users.h"	/* users func. */
> +
> +#include "hs_test.h"
> +#include "cleanup.h"
> +
> +/* prefixes and postfixes of files and dirs */
> +static const char* file_postfix = ".hsym";
> +static const char* symlink_prefix = "sym";
> +static const char* symlink_dir_prefix = "dsy";
> +static const char* hardlink_prefix = "hrd";
> +
> +/* base directories to test */
> +struct base_test_dir
> +{
> +	const char* path;
> +	const char* user_name;
> +	const int world_writable;
> +	const int sticky;
> +	const int create;
> +};
> +
> +enum TEST_DIRS {
> +	TEST_DIR=0,
> +	TEST_TMP_DIR,
> +	TMP_DIR,
> +	TEST_DIR_NUM
> +};
> +
> +/* this base dirs which will be created */
> +static struct base_test_dir test_dir[] = {
> +	[TEST_DIR] = {
> +		.path = "/tmp_test",
> +		.user_name = "root",
> +		.world_writable = 1,
> +		.sticky = 0,
> +		.create = 1,
> +	},	
> +	[TEST_TMP_DIR] = {
> +		.path = "/tmp_test/tmp",
> +		.user_name = "root",
> +		.world_writable = 1,
> +		.sticky = 1,
> +		.create = 1,
> +	},
> +	[TMP_DIR] = {
> +		.path = "/tmp",
> +		.user_name = "root",
> +		.world_writable = 1,
> +		.sticky = 1,
> +		.create = 0,
> +	},
> +};

I don't like the indexing by the enum here. Just looping over the array
of structures should be enough.

You really should use ARRAY_SIZE() macro to determine the lenght rather
thatn TEST_DIR_NUM.

> +/* create 3 files and 1 dir in each base dir */
> +#define MAX_FILES_CREATED 	4
> +#define MAX_PATH 		128
> +#define MIN_PATH 		2
> +
> +/*
> + * max test files and directories 
> + * that will be created during the test
> + * is't not include symlinks and hardlinks
> + * and base directories
> + */
> +#define MAX_ENTITIES 	MAX_FILES_CREATED*TEST_DIR_NUM
> +struct user_file {
> +	char file[MAX_ENTITIES][MAX_PATH];
> +	int is_dir[MAX_ENTITIES];
> +	int num;	/* number of files */
> +};
> +/* create struct for each user */
> +static struct user_file ufiles[USERS_NUM];
> +
> +#define MAX_SYMLINKS	MAX_ENTITIES*USERS_NUM*USERS_NUM*TEST_DIR_NUM
> +#define MAX_HARDLINKS	MAX_SYMLINKS
> +
> +enum {
> +    IS_FILE=0,
> +    IS_DIRECTORY,
> +};
> +
> +/* test info about link */
> +struct hs_link
> +{

Here the curly brace should be at the end of the struct hs_link.

> +	char path[MAX_PATH];
> +	char owner[MAX_USER_NAME];
> +	char source_owner[MAX_USER_NAME];
> +	int in_wwd; 	/* link in world-writable directory */
> +	int in_sticky; 	/* link in sticky directory */
> +	int is_dir; 	/* just for symlinks */
> +};
> +
> +/* simple struct to save info about created links */
> +struct hs_links
> +{

Here as well.

> +	struct hs_link sym[MAX_SYMLINKS];
> +	struct hs_link hrd[MAX_HARDLINKS];
> +	
> +	int s_num; /* symlinks number */
> +	int h_num; /* hardlinks number */
> +};
> +
> +/* struct to keep all created links for test */
> +static struct hs_links links;
> +
> +/* test flags */
> +enum {
> +	CANNOT_FOLLOW=-1,
> +	CAN_FOLLOW=0,
> +};
> +
> +enum {
> +	CANNOT_CREATE=-1,
> +	CAN_CREATE=0,
> +};
> +
> +/* create hardlinks */
> +static int create_links(void);

Again the comment doesn't provide more information than the function
name, just delete it.

> +/* add new created files to ufiles struct */
> +static void ufiles_add(const int* id, const char* path, const int is_dir);
> +
> +/* cleanup function */
> +void delete_files(void)
> +{
> +	tst_resm(TINFO,"Remove tmp files...");
> +	
> +	/* remove all users files */
> +	int j,p;
> +	for(j=0;j<USERS_NUM;++j) {
> +		for(p=0;p<ufiles[j].num;++p) {
> +			if(!ufiles[j].is_dir[p])
> +				remove(ufiles[j].file[p]);
> +		}
> +	}
> +
> +	/* delete hard links */
> +	for(j=0;j<links.h_num;++j)
> +		remove(links.hrd[j].path);
> +
> +	/* delete symlinks */
> +	for(j=0;j<links.s_num;++j)
> +		remove(links.sym[j].path);
> +
> +	/* delete directories */
> +	for(j=0;j<USERS_NUM;++j) {
> +		for(p=0;p<ufiles[j].num;++p) {
> +			if(ufiles[j].is_dir[p])
> +				remove(ufiles[j].file[p]);
> +		}
> +	}
> +
> +	/* delete base directories */
> +	for(j=TEST_DIR_NUM-1;j>=0;--j) {
> +		const struct base_test_dir* tdir = &test_dir[j];
> +		if(tdir->create)
> +			remove(tdir->path);
> +	}

You should use tst_tmpdir() and tst_rmdir(). The latter would clean the
thest temp dir for you. No need to write code such as this.

> +}
> +
> +char rchar()
> +{

Missing void

> +    /* return random character from A...Z */
> +    return (rand()%0x19+0x41);
> +}
> +
> +void hs_test_init(void)
> +{
> +	cleanup_add(&delete_files);
> +
> +	/* initialize random seed */
> +	srand( time(NULL) );
> +	 
> +	tst_resm(TINFO," -- Hard & Symbolic links restriction test -- \n");
> +
> +	/* init the links struct */
> +	memset(&links,0,sizeof(links));
> +	
> +	/* init struct to store info about created files */
> +	memset(&ufiles,0,sizeof(ufiles));
> +
> +	/* create main directories */
> +	int i;
> +	for(i=0;i<TEST_DIR_NUM;++i) {
> +		if( !test_dir[i].create ) continue;
> +		const struct base_test_dir* tdir = &test_dir[i];
> +
> +		SAFE_MKDIR(&cleanup,tdir->path,	S_IRWXU | 
> +						S_IRGRP | S_IXGRP |
> +						S_IROTH | S_IXOTH 
> +						/* 0755 */);
> +
> +		mode_t mode = 0;
> +
> +		if( tdir->world_writable )
> +			mode = S_IRWXU | S_IRWXG | S_IRWXO;
> +			
> +		if( tdir->sticky )
> +			mode |= S_ISVTX; 
> +
> +		if(mode) chmod(tdir->path, mode);
> +
> +	} //for
           ^
          Comments like this are no go.

> +	/* create all other directories and files */		
> +	for(i=0;i<TEST_DIR_NUM;++i) {
> +		const struct base_test_dir* tdir = &test_dir[i];
> +		
> +		int k;
> +		for(k = 0;k<USERS_NUM;++k) {
> +			
> +			set_user( _users[k] );
> +			
> +			/* create file in the main directory */
> +			char fpath[MAX_PATH];
> +			sprintf(fpath,"%s/%s%s",
> +				tdir->path,_users[k],file_postfix);
> +			ufiles_add(&k, fpath, IS_FILE);
> +			SAFE_CREAT(	&cleanup,fpath,		/* 0644 */
> +					S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
> +			
> +			
> +			/* create file with S_IWOTH bit set */
> +			char w_fpath[MAX_PATH];
> +			strcpy(w_fpath, fpath);
> +			strcat(w_fpath,"_w");
> +			ufiles_add(&k, w_fpath, IS_FILE);
> +			SAFE_CREAT(	&cleanup,w_fpath,	/* 0644 */
> +					S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
> +			/* change permissions r--r--rw*/
> +			chmod(w_fpath,	S_IRUSR | /* skip S_IWUSR | */
> +					S_IRGRP | S_IWGRP |
> +					S_IWOTH | S_IROTH);
> +
> +			/* create sub directory */
> +			char sub_dpath[MAX_PATH];
> +			sprintf(sub_dpath,"%s/%s_%c%c%c%c%c", tdir->path,
> +				_users[k],rchar(),rchar(),rchar(),rchar(),rchar());
> +			ufiles_add(&k, sub_dpath, IS_DIRECTORY);
> +			SAFE_MKDIR(&cleanup,sub_dpath,	S_IRWXU |
> +							S_IRGRP | S_IXGRP |
> +							S_IROTH | S_IXOTH 
> +							/* 0755 */);
> +
> +			/* create local file inside user directory */
> +			strcat(sub_dpath,"/local_");
> +			strcat(sub_dpath,_users[k]);
> +			strcat(sub_dpath,file_postfix);

Don't use several strcats where one snprintf() would suffice.

> +			ufiles_add(&k, sub_dpath, IS_FILE);
> +			SAFE_CREAT(	&cleanup,sub_dpath,	/* 0644 */
> +					S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
> +		} /* for(each user) */
                            ^
			Here as well.

> +	}
> +	
> +}
> +
> +static void ufiles_add(const int* id, const char* path, const int is_dir) 
> +{
> +	if(!id) return;
> +	if(ufiles[*id].num>=MAX_ENTITIES)
> +		tst_brkm(TBROK,&cleanup,"Unexpected number of files");
> +
> +	strcpy(ufiles[*id].file[ ufiles[*id].num ], path);
> +	ufiles[*id].is_dir[ ufiles[*id].num ] = is_dir;
> +	++ufiles[*id].num;
> +}
> +
> +static void create_link_path(	char* buffer, const char* path,
> +				const char* prefix,	const char* owner, 
> +				const char* source_owner, const char* postfix) 
> +{
> +	/* to make sure name is unique */
> +	static int count = 0;
> +	++count;
> +	
> +	int len = strlen(path) + strlen(prefix) + strlen(owner) +
> +		strlen(source_owner) + strlen(postfix);
> +
> +	if ( len>MAX_PATH || len<MIN_PATH )
> +		tst_brkm(TBROK,&cleanup,"Length of the new symlink %d, "
> +			"should be between min(%d) <len< max(%d)",
> +			len, MIN_PATH, MAX_PATH);
> +	/* construct link name */
> +	sprintf(buffer,"%s/%s_%s_%s_%d%s",
> +			path, prefix, owner, source_owner,
> +			count, postfix);
> +}
> +
> +static void show_mode(char* buffer, const mode_t* mode)
> +{
> +	sprintf(buffer,"%c%c%c %c%c%c %c%c%c",
> +		*mode&S_IRUSR?'r':'-',*mode&S_IWUSR?'w':'-',*mode&S_IXUSR?'x':'-',
> +		*mode&S_IRGRP?'r':'-',*mode&S_IWGRP?'w':'-',*mode&S_IXGRP?'x':'-',
> +		*mode&S_IROTH?'r':'-',*mode&S_IWOTH?'w':'-',*mode&S_IXOTH?'x':'-');
> +}
> +
> +/* create hard and symlinks */
> +static int create_links(void) 
> +{
> +	int k;
> +	int hlink_result = 0;
> +	int hlink_tests_count = 0;
> +
> +	for(k=0;k<USERS_NUM;++k) {
> +		/* set user who will create symlinks */
> +		set_user( _users[k] );
> +
> +		/* create symlinks from each user 
> +		 * to each world writable directory
> +	 	*/
> +		int j,p,i;
> +
> +		for(j=0;j<USERS_NUM;++j) {
> +
> +			/* get all users files and directories */
> +			for(p=0;p<ufiles[j].num;++p) {
> +				/* get all world-writable directrories */
> +				for(i=0;i<TEST_DIR_NUM;++i) {
> +
> +					char new_path[MAX_PATH];
> +					char hlink_path[MAX_PATH];
> +
> +					const struct base_test_dir* tdir = &test_dir[i];
> +
> +					/* create symlink */
> +					const int* is_dir = &ufiles[j].is_dir[p];
> +					create_link_path(new_path,tdir->path,
> +						(*is_dir==1)?symlink_dir_prefix:symlink_prefix, _users[k],
> +						_users[j],(*is_dir==1)?"":file_postfix);

This code is ugly and overflows 80 lines.

> +
> +
> +					/* create path for hard link */
> +					create_link_path(hlink_path,tdir->path,
> +							hardlink_prefix, _users[k],
> +							_users[j],file_postfix);
> +
> +					strcpy(links.sym[links.s_num].owner,_users[k]);
> +					strcpy(links.sym[links.s_num].source_owner,_users[j]);
> +					
> +					links.sym[links.s_num].in_wwd = tdir->world_writable;
> +					links.sym[links.s_num].in_sticky = tdir->sticky;
> +					links.sym[links.s_num].is_dir = *is_dir;
> +
> +					/* add symlink to array */
> +					strcpy( links.sym[links.s_num].path, new_path );
> +					if(links.s_num>=MAX_SYMLINKS)
> +						tst_brkm(TBROK,&cleanup,"Unexpected number of symlinks");
> +					++(links.s_num);
> +
> +					create_symlink( ufiles[j].file[p], new_path);
> +
> +					/* 
> +					 * Hard Link Test-Case
> +					 * Hard link can only be created if user has write access to a file or
> +					 * owner of the file.
> +					 */
> +					
> +					if (*is_dir) continue;
> +					
> +					struct stat stat_buf;
> +
> +					/* don't have access */
> +					if (stat (ufiles[j].file[p], &stat_buf) == -1)
> +						continue;
> +					
> +					/* current user has the same uid and gid */
> +					int user_is_owner =	stat_buf.st_uid == geteuid() && 
> +								stat_buf.st_gid == getegid();
> +					
> +					/* curent user has write access */
> +					int user_can_write = stat_buf.st_mode & S_IWOTH;
> +
> +					int test_flag = (user_can_write || user_is_owner ||
> +							k == ROOT )?CAN_CREATE:CANNOT_CREATE;
> +					
> +					if(links.h_num>=MAX_HARDLINKS)
> +						tst_brkm(TBROK,&cleanup,"Unexpected number of symlinks");
> +					strcpy(links.hrd[links.h_num].path,hlink_path);
> +					++links.h_num;
> +					int res = (test_flag!=create_link(ufiles[j].file[p], hlink_path));
> +					
> +					/* return 1 if one of the tests has failed */
> +					hlink_result |= res;
> +					++hlink_tests_count;
> +					
> +					char mode_buff[32];
> +					show_mode(mode_buff,&stat_buf.st_mode);
> +
> +					tst_resm((res==1)?TFAIL:TPASS,
> +						"Expected: %s create hard link from file %s, to file %s, "
> +						"file's owner (%s), current user (%s), file mode (%s)",
> +						(test_flag==CAN_CREATE)?"can":"can't",
> +						ufiles[j].file[p],
> +						hlink_path,
> +						_users[j],_users[k],
> +						mode_buff);
> +
> +				} /* for(each directory) */
> +			} /* for(each file) */
> +		} /* for(each user) */
> +	} /* for(each user) */
                        ^
This comments are even bigger no no.

> +	return hlink_result;
> +}
> +
> +int check_all_symlinks(void) {
> +	
> +	int symlink_result = 0;
> +	/* root can follow all links except links */
> +	/* in world writable directories and links's */
> +	/* owner isn't root */
> +	int k,i;
> +	for(k=0;k<USERS_NUM;++k) {
> +		set_user(_users[k]);
> +		
> +		for(i=0;i<links.s_num;++i) {
> +			int root_isnt_owner = strcmp(links.sym[i].owner,_users[ROOT]);
> +
> +			int test_flag = CAN_FOLLOW;
> +			if( k==ROOT && links.sym[i].in_wwd &&
> +				links.sym[i].in_sticky && root_isnt_owner) {
> +
> +				/* We can't follow link */
> +				test_flag = CANNOT_FOLLOW;
> +			}
> +
> +			int res = (test_flag!=check_symlink(links.sym[i].path));
> +
> +			/* return 1 if one of the tests has failed */
> +			symlink_result |= res;
> +
> +			tst_resm((res==1)?TFAIL:TPASS,"Expected: %s follow symlink %s, "
> +					"link's owner (%s), target's owner (%s), "
> +					"user who's tried (%s)",
> +					(test_flag==CAN_FOLLOW)?"can":"can't",
> +					links.sym[i].path, links.sym[i].owner,
> +					links.sym[i].source_owner, _users[k]);
> +		} /* for(links) */
> +	} /* for(users) */
> +
> +	return symlink_result;
> +}
> +
> +int hs_test_run(void)
> +{
> +	/* init header for hard link test */
> +	tst_resm(TINFO," --- TEST HARD LINKS RESTRICTION --- \n");
> +	/* create symlinks from each file and directory */
> +	int result_hard_links = create_links();
> +
> +	tst_resm(TINFO," --- TEST SYMBOLIC LINKS RESTRICTION --- \n");
> +	int result_sym_links = check_all_symlinks();
> +
> +	/* final results */
> +	tst_resm(TINFO,"All TEST-CASES have been completed, summary:\n"
> +				" - %d\thardlinks created\ttests: %s\n"
> +				" - %d\tsymlinks  created\ttests: %s",
> +				links.h_num, (result_hard_links==1)?"FAIL":"PASS",
> +				links.s_num, (result_sym_links ==1)?"FAIL":"PASS");
> +
> +	/* set back privileged user to allow creation of gmon.out if ever needed */
> +	set_user(_users[ROOT]);
> +	
> +	return (result_hard_links | result_sym_links);
> +}
> diff --git a/testcases/kernel/security/prot_hsymlinks/hs_test.h b/testcases/kernel/security/prot_hsymlinks/hs_test.h
> new file mode 100644
> index 0000000..6c950b3
> --- /dev/null
> +++ b/testcases/kernel/security/prot_hsymlinks/hs_test.h
> @@ -0,0 +1,47 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author:
> + * Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + * File: hs_test.h
> + *
> + * Test implementation
> + * -------------------
> + * Symlinks restriction applies only to privileged users (other
> + * combinations of non-privileged user, sticky bit and world-writable
> + * dirs are not affected). Only privileged user can't follow symlinks in 
> + * only sticky world-writable directory if he isn't owner of that link. 
> + * All other users can.
> + *
> + * Hard links restriction applies only to non-privileged users. Only 
> + * non-privileged user can't create hard links to files if he isn't owner 
> + * of the file or he doesn't have write access to the file despite of 
> + * file's directory permission.
> + */
> +
> +#ifndef HS_TEST_FILE_H
> +#define HS_TEST_FILE_H
> +
> +/* init of the tests */
> +extern void hs_test_init(void);
> +
> +/* run all tests
> + * return 1, if one of the test-cases has failed
> + */
> +extern int hs_test_run(void);
> +
> +#endif /* TEST_FILE_H */
> diff --git a/testcases/kernel/security/prot_hsymlinks/options.c b/testcases/kernel/security/prot_hsymlinks/options.c
> new file mode 100644
> index 0000000..eecd23e
> --- /dev/null
> +++ b/testcases/kernel/security/prot_hsymlinks/options.c
> @@ -0,0 +1,104 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author:
> + * Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + * File: options.c
> + *
> + * Implements program options
> + */
> +
> +#include <string.h>
> +#include <stdlib.h>
> +#include <getopt.h>
> +
> +#include <test.h>
> +
> +#include "cleanup.h"
> +#include "options.h"
> +
> +static const char* program_name;
> +
> +char _users[USERS_NUM][MAX_USER_NAME];
> + 
> +static void print_usage (FILE* stream, int exit_code)
> +{
> +    fprintf (stream, "Usage: %s options:\n", program_name);
> +    fprintf (stream,
> +    " -h --help Display this usage information.\n"
> +    " -s --skip Skip cleanup.\n"
> +    " -u --define test user name.\n"
> +			);
> +    tst_brkm(TBROK,&cleanup, "Print usage");
> +}
> +
> +void init_options(int argc,char **argv)
> +{
> +	int next_option;
> +	/* A string listing valid short options letters. */
> +	const char* const short_options = "hsu:";
> +
> +	/* An array describing valid long options. */
> +	const struct option long_options[] = {
> +	    { "help", 0, NULL, 'h' },
> +	    { "skip", 0, NULL, 's' },
> +	    { "user", 0, NULL, 'u' },
> +	    { NULL, 0, NULL, 0 } /* Required at end of array. */
> +	};
> +	program_name = argv[0];
> +
> +	const char* tmp_user_name=NULL;
> +	do {
> +		next_option = getopt_long (argc, argv, short_options,
> +				    long_options, NULL);
> +		switch (next_option) {
> +		case 'h': /* -h or --help */
> +			print_usage (stdout, 1);
> +		break;
> +		case 'u': /* -u or --user */
> +			tmp_user_name = optarg;
> +		break;
> +		case 's': /* -s or --skip */
> +			_skip_cleanup = 1;
> +		break;
> +		case '?': 
> +			/* The user specified an invalid option. */
> +			print_usage (stderr, 1);
> +		case -1: /* Done with options. */
> +		break;
> +		default: /* Something else: unexpected. */
> +			print_usage(stderr,1);
> +		}
> +	} while (next_option != -1);
> +
> +
> +	/* initialize user names */
> +	/* 1st user always root */
> +	strcpy(_users[ROOT],"root");
> +
> +	/* create defualt user, if it's not defined in program's arguments */
> +	if(tmp_user_name==NULL || strlen(tmp_user_name)<MIN_USER_NAME ||
> +		!strcmp(tmp_user_name,"root") )
> +		strcpy(_users[TEST_USER],"userhsym");
> +	else {
> +		if(strlen(tmp_user_name)>=MAX_USER_NAME) {
> +			strncpy(_users[TEST_USER],tmp_user_name,MAX_USER_NAME-1);
> +			_users[TEST_USER][MAX_USER_NAME-1]='\0';
> +		} else
> +			strcpy(_users[TEST_USER],tmp_user_name);
> +	}		
> +}

Use standard LTP parse_opts(), do not reinvent the wheel.

> diff --git a/testcases/kernel/security/prot_hsymlinks/options.h b/testcases/kernel/security/prot_hsymlinks/options.h
> new file mode 100644
> index 0000000..d4f00cb
> --- /dev/null
> +++ b/testcases/kernel/security/prot_hsymlinks/options.h
> @@ -0,0 +1,39 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author:
> + * Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + * File: options.h
> + *
> + * Implements program options
> + */
> +
> +#ifndef OPTIONS_FILE_H
> +#define OPTIONS_FILE_H
> +
> +#include <stdio.h>
> +
> +#include "wrp_users.h"
> +
> +/* users who will be participate in the tests */
> +extern char _users[USERS_NUM][MAX_USER_NAME];
> +
> +/* init program options */
> +extern void init_options(int argc,char **argv);
> +
> +
> +#endif /* OPRIONS_FILE_H */
> diff --git a/testcases/kernel/security/prot_hsymlinks/wrp_links.c b/testcases/kernel/security/prot_hsymlinks/wrp_links.c
> new file mode 100644
> index 0000000..62e895b
> --- /dev/null
> +++ b/testcases/kernel/security/prot_hsymlinks/wrp_links.c
> @@ -0,0 +1,101 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author:
> + * Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + * File: wrp_links.c
> + *
> + * Implements functions to deal 
> + * with hard and symbolic links
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <fcntl.h>
> +
> +#include <test.h>
> +
> +#include "cleanup.h"
> +#include "wrp_links.h"
> +
> +struct open_modes {
> +	const char* name;
> +	const int mode;
> +};
> +
> +/* differenet modes to try in the test */
> +static const struct open_modes o_modes[] = {
> +	{
> +		.name 	= "O_RDONLY",
> +		.mode	= O_RDONLY,
> +	},
> +	{
> +		.name	= "O_WRONLY",
> +		.mode	= O_WRONLY,
> +	},
> +	{
> +		.name	= "O_RDWR",
> +		.mode	= O_RDWR,
> +	},
> +	{
> +		.name	= "O_RDONLY | O_NONBLOCK | O_DIRECTORY",
> +		.mode	= O_RDONLY | O_NONBLOCK | O_DIRECTORY,
> +	},
> +	{ .name = NULL, .mode = -1, } /* end */
> +};
> +
> +
> +int check_symlink(const char* name) 
> +{
> +	int result = 0;
> +	
> +	const struct open_modes *o_mode = o_modes;
> +	
> +	while(o_mode->mode!=-1) {
> +		
> +		int fd = open(name, o_mode->mode);
> +		if(fd==-1) {
> +			/* can't open, continue testing */
> +			result = -1;
> +			++o_mode;
> +			continue;
> +		} else
> +		if (close(fd)==-1) {
> +		    tst_brkm(TBROK,&cleanup,"Can't close symlink: %s",name);
> +		}

The indendtation is wrong here.

> +		result = 0;
> +		break;
> +	}
> +
> +	return result;
> +}
> +
> +int create_link(const char* old_path, const char* new_path)
> +{
> +	int result = link(old_path,new_path);
> +	return result;
> +}

What is this wrapper good for?

> +void create_symlink(const char* old_path, const char* new_path)
> +{
> +	if (symlink(old_path,new_path)==-1) {
> +		fprintf(stderr,"Can't create symlink from %s, to %s\n",
> +						old_path, new_path);
> +	}
> +}

You are not using the LTP interface.

> diff --git a/testcases/kernel/security/prot_hsymlinks/wrp_links.h b/testcases/kernel/security/prot_hsymlinks/wrp_links.h
> new file mode 100644
> index 0000000..e319f48
> --- /dev/null
> +++ b/testcases/kernel/security/prot_hsymlinks/wrp_links.h
> @@ -0,0 +1,38 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author:
> + * Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + * File: wrp_links.h
> + *
> + * Implements functions to deal 
> + * with hard and symbolic links
> + */
> +
> +#ifndef LINKS_FILE_H
> +#define LINKS_FILE_H
> +
> +/* create symbolic link */
> +extern void create_symlink(const char* old_path, const char* new_path);
> +
> +/* it checks symlinks in multi-mode, return -1 if can't follow, 0 - if can */
> +extern int check_symlink(const char* name);
> +
> +/* create hard link */
> +extern int create_link(const char* old_path, const char* new_path);
> +
> +#endif /* LINKS_FILE_H */
> diff --git a/testcases/kernel/security/prot_hsymlinks/wrp_users.c b/testcases/kernel/security/prot_hsymlinks/wrp_users.c
> new file mode 100644
> index 0000000..7abfff6
> --- /dev/null
> +++ b/testcases/kernel/security/prot_hsymlinks/wrp_users.c
> @@ -0,0 +1,55 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author:
> + * Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + * File: wrp_users.c
> + *
> + * Changes effective user id
> + */
> +
> +#include <pwd.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +/* LTP include */
> +#include <test.h>
> +#include <safe_macros.h>
> +
> +#include "cleanup.h"
> +#include "wrp_users.h"
> +
> +void set_user(const char* name)
> +{
> +	struct passwd *pswd = getpwnam (name);
> +
> +	/* if can't find the user */
> +	if(pswd==0)
> +		tst_brkm(TBROK,&cleanup,"The user (%s) has to exist "
> +						"on this machine to perform the test",
> +						name);
> +
> +	uid_t user_id = pswd->pw_uid;
> +	gid_t user_gr = pswd->pw_gid;
> +
> +	/* change effective user id and group id to test user */
> +	SAFE_SETEGID(&cleanup,user_gr);
> +
> +	SAFE_SETEUID(&cleanup,user_id);
> +}
> diff --git a/testcases/kernel/security/prot_hsymlinks/wrp_users.h b/testcases/kernel/security/prot_hsymlinks/wrp_users.h
> new file mode 100644
> index 0000000..9ff49a2
> --- /dev/null
> +++ b/testcases/kernel/security/prot_hsymlinks/wrp_users.h
> @@ -0,0 +1,40 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author:
> + * Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + * File: wrp_users.h
> + *
> + * Changes effective user id
> + */
> +
> +#ifndef USERS_FILE_H
> +#define USERS_FILE_H
> +
> +#define MIN_USER_NAME 1
> +#define MAX_USER_NAME 16
> +
> +enum USERS {
> +	ROOT=0,
> +	TEST_USER,
> +	USERS_NUM
> +};
> +
> +/* set effective user id and group id by name */
> +extern void set_user(const char* name);
> +
> +#endif /* USERS_FILE_H */

Generally, the code reinvents the wheel.

And I don't like how it is scattered between several files.

Make it simpler, consistent and make use of standard LTP intefaces.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
