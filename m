From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Nov 2020 22:47:01 +0100
Subject: [LTP] [PATCH v4 0/6] Introduce SAFE_FANOTIFY_MARK() macro +
 cleanup
In-Reply-To: <20201126214121.6836-1-pvorel@suse.cz>
References: <20201126214121.6836-1-pvorel@suse.cz>
Message-ID: <20201126214701.GA8026@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

BTW:

FYI this is the first pachset which broke CentOS 6
(kernel: 2.6.32-696, glibc: 2.12).
But we've just agreed to not support it...

In file included from fanotify01.c:21:
fanotify.h: In function ?require_fanotify_access_permissions_supported_by_kernel?:
fanotify.h:301: warning: implicit declaration of function ?SAFE_FANOTIFY_INIT?
fanotify.h:301: error: ?FAN_CLASS_CONTENT? undeclared (first use in this function)
fanotify.h:301: error: (Each undeclared identifier is reported only once
fanotify.h:301: error: for each function it appears in.)
fanotify.h:303: error: ?FAN_MARK_ADD? undeclared (first use in this function)
fanotify.h:303: error: ?FAN_ACCESS_PERM? undeclared (first use in this function)
fanotify.h: In function ?fanotify_exec_events_supported_by_kernel?:
fanotify.h:321: error: ?FAN_CLASS_CONTENT? undeclared (first use in this function)
fanotify.h:323: error: ?FAN_MARK_ADD? undeclared (first use in this function)
fanotify.h: In function ?fanotify_fan_report_fid_supported_on_fs?:
fanotify.h:342: error: ?FAN_CLASS_NOTIF? undeclared (first use in this function)
fanotify.h:344: error: ?FAN_MARK_ADD? undeclared (first use in this function)
fanotify.h:345: error: ?FAN_ACCESS? undeclared (first use in this function)
fanotify.h:345: error: ?FAN_MODIFY? undeclared (first use in this function)
fanotify.h:345: error: ?FAN_CLOSE? undeclared (first use in this function)
fanotify.h:345: error: ?FAN_OPEN? undeclared (first use in this function)
make: *** [fanotify01] Error 1
make: *** Waiting for unfinished jobs....
In file included from fanotify02.c:21:
fanotify.h: In function ?require_fanotify_access_permissions_supported_by_kernel?:
fanotify.h:301: warning: implicit declaration of function ?SAFE_FANOTIFY_INIT?
fanotify.h:301: error: ?FAN_CLASS_CONTENT? undeclared (first use in this function)
fanotify.h:301: error: (Each undeclared identifier is reported only once
fanotify.h:301: error: for each function it appears in.)
fanotify.h:303: error: ?FAN_MARK_ADD? undeclared (first use in this function)
fanotify.h:303: error: ?FAN_ACCESS_PERM? undeclared (first use in this function)
fanotify.h: In function ?fanotify_exec_events_supported_by_kernel?:
fanotify.h:321: error: ?FAN_CLASS_CONTENT? undeclared (first use in this function)
fanotify.h:323: error: ?FAN_MARK_ADD? undeclared (first use in this function)
fanotify.h: In function ?fanotify_fan_report_fid_supported_on_fs?:
fanotify.h:342: error: ?FAN_CLASS_NOTIF? undeclared (first use in this function)
fanotify.h:344: error: ?FAN_MARK_ADD? undeclared (first use in this function)
fanotify.h:345: error: ?FAN_ACCESS? undeclared (first use in this function)
fanotify.h:345: error: ?FAN_MODIFY? undeclared (first use in this function)
fanotify.h:345: error: ?FAN_CLOSE? undeclared (first use in this function)
fanotify.h:345: error: ?FAN_OPEN? undeclared (first use in this function)
make: *** [fanotify02] Error 1

Kind regards,
Petr
