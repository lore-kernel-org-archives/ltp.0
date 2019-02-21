From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Feb 2019 17:42:35 +0100
Subject: [LTP] [PATCH 1/5] syscalls/fanotify03: defined additional tcase
 members for added control
In-Reply-To: <20190122223526.GA32694@lithium.mbobrowski.org>
References: <20190122223526.GA32694@lithium.mbobrowski.org>
Message-ID: <20190221164234.GD17813@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've finally started to look into this patchset (sorry for the long delay), the
changes to fanotify03 looks good to me and I wanted to push them, but I'm
getting rejects:

Checking patch testcases/kernel/syscalls/fanotify/fanotify03.c...
error: while searching for:

static pid_t child_pid;

static unsigned long long event_set[EVENT_MAX];
static unsigned int event_resp[EVENT_MAX];

static char event_buf[EVENT_BUF_LEN];
static int support_perm_events;

static struct tcase {
        const char *tname;
        struct fanotify_mark_type mark;
} tcases[] = {
        {
                "inode mark permission events",
                INIT_FANOTIFY_MARK_TYPE(INODE),
        },
        {
                "mount mark permission events",
                INIT_FANOTIFY_MARK_TYPE(MOUNT),
        },
        {
                "filesystem mark permission events",
                INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
        },
};

static void generate_events(void)

error: patch failed: testcases/kernel/syscalls/fanotify/fanotify03.c:42
Hunk #3 succeeded at 147 (offset -21 lines).
error: while searching for:
                }
        } else {
                /*
                 * To distigouish between perm event not supported and
                 * filesystem mark not supported.
                 */
                support_perm_events = 1;


Is this based on some yet to be merged patchset?

-- 
Cyril Hrubis
chrubis@suse.cz
