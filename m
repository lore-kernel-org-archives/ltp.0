From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 Oct 2018 13:18:18 +0200
Subject: [LTP] [PATCH RFC] lib: add helper funcs to save and restore
 /proc|sys content
In-Reply-To: <bc3a3f3599064b34d60a2f2f21c5cac578582a50.1539866505.git.jstancek@redhat.com>
References: <bc3a3f3599064b34d60a2f2f21c5cac578582a50.1539866505.git.jstancek@redhat.com>
Message-ID: <20181019111817.GA31934@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> To avoid adding specially crafted functions for every feature
> where we need to save/restore some proc/sys config, this patch
> introduces a struct (linked list) where user pushes files names
> whose values should be saved. These can be later restored in
> cleanup or during the test.

This is a great idea, but I guess that the user API could be even more
simplified.

I would go for an NULL terminated array of strings that could be passed
in the tst_test structure. Also that way the values would be restored in the
test library even after the test has crashed.

Something as:

static const char *save_restore[] = {
	"/proc/sys/kernel/core_pattern",
	"/proc/sys/kernel/numa_balancing",
	NULL,
};


static struct tst_test test = {
	...

	.save_restore = save_restore,
};

What do you think?

-- 
Cyril Hrubis
chrubis@suse.cz
