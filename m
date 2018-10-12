From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 12 Oct 2018 09:02:29 -0400 (EDT)
Subject: [LTP] [PATCH] syslog/syslog-lib.sh: Match rsyslog config
 written by RainerScript
In-Reply-To: <1539249654-24401-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1539249654-24401-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <555408112.57853699.1539349349506.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Since rsyslog commit 3b55048094d759adf8162f0829f239e115ebf2c0, rsyslog
> by default deletes log socket during restart, unless socket is provided
> by systemd.
> 
> If default rsyslog config written by RainerScript uses imjournal module
> (e.g. module(load="imjournal"...) and doesn't specify $SystemLogSocketName,
> syslog-lib.sh cannot match imjournal module and just write imuxsock module
> into the rsyslog.conf constructed by test.  In this case, "/dev/log" is
> owned by journald but rsyslog deletes it as its default log socket after
> testing.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Pushed with added comment what patterns is the grep targetting.

Thanks,
Jan
