From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 9 Oct 2019 12:39:37 -0400 (EDT)
Subject: [LTP] systemd v243 and OOMs // Was: CKI moving to Fedora 31 for
 upstream jobs
In-Reply-To: <441865364.5393998.1570638574134.JavaMail.zimbra@redhat.com>
References: <1d51b701-2210-360f-588b-f25fc22b09b3@redhat.com>
 <1909680792.5387095.1570635404942.JavaMail.zimbra@redhat.com>
 <441865364.5393998.1570638574134.JavaMail.zimbra@redhat.com>
Message-ID: <1307292443.5395186.1570639177003.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> ----- Original Message -----
> > * LTP aborts after max_map_count
> > [10885.979005] LTP: starting max_map_count (max_map_count -i 10)
> > [-- MARK -- Tue Oct? 8 15:05:00 2019]
> > [-- MARK -- Tue Oct? 8 15:10:00 2019]
> > [-- MARK -- Tue Oct? 8 15:15:00 2019]
> > [-- MARK -- Tue Oct? 8 15:20:00 2019]
> 
> This is strange.
> 
> It looks kind-of OOM related, because 'restraintd' process just disappears
> while running oom01. There's no message from OOM that it was killed.

(forwarding to LTP for fyi)

New systemd (v243) has a feature, which appears to be killing our test harness by default.

https://www.freedesktop.org/software/systemd/man/systemd.service.html#
  "OOMPolicy= ... If set to stop the event is logged but the service is terminated cleanly by the service manager."

Harness process (started by systemd) starts LTP. LTP runs oom01, where child process gets
killed by OOM and then systemd "cleans up" harness service and job aborts:

Oct 09 12:08:44 hp-dl180-02.khw.lab.eng.bos.redhat.com restraintd[830]: *** Current Time: Wed Oct 09 12:08:44 2019 Localwatchdog at: Wed Oct 09 15:13:43 2019
Oct 09 12:09:44 hp-dl180-02.khw.lab.eng.bos.redhat.com restraintd[830]: *** Current Time: Wed Oct 09 12:09:44 2019 Localwatchdog at: Wed Oct 09 15:13:43 2019
Oct 09 12:10:48 hp-dl180-02.khw.lab.eng.bos.redhat.com systemd[1]: restraintd.service: A process of this unit has been killed by the OOM killer.
Oct 09 12:12:51 hp-dl180-02.khw.lab.eng.bos.redhat.com restraintd[830]: *** Current Time: Wed Oct 09 12:10:51 2019 Localwatchdog at: Wed Oct 09 15:13:43 2019
Oct 09 12:12:54 hp-dl180-02.khw.lab.eng.bos.redhat.com systemd[1]: restraintd.service: A process of this unit has been killed by the OOM killer.
Oct 09 12:13:04 hp-dl180-02.khw.lab.eng.bos.redhat.com restraintd[830]: Modules Loaded         nls_utf8 isofs dummy veth minix nfsv3 nfs_acl nfs lockd grace >
Oct 09 12:12:54 hp-dl180-02.khw.lab.eng.bos.redhat.com systemd[1]: restraintd.service: Killing process 830 (restraintd) with signal SIGKILL.
Oct 09 12:13:03 hp-dl180-02.khw.lab.eng.bos.redhat.com systemd[1]: restraintd.service: Main process exited, code=killed, status=9/KILL
Oct 09 12:13:03 hp-dl180-02.khw.lab.eng.bos.redhat.com systemd[1]: restraintd.service: Failed with result 'oom-kill'.

Regards,
Jan
