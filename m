From: Li Wang <liwang@redhat.com>
Date: Wed, 31 Jul 2019 17:02:25 +0800
Subject: [LTP] [PATCH] syslog: fix sporadic failures due to
 rate-limitting
In-Reply-To: <1049532097.3289438.1564481693647.JavaMail.zimbra@redhat.com>
References: <6db4a928733290dca3b2e4b4a27f1cb69d805401.1563959090.git.jstancek@redhat.com>
 <CAEemH2dqE8Ad_r+vnrd0BnBoyOO9GTLoE20SPSQtV7mbr-Yabg@mail.gmail.com>
 <1049532097.3289438.1564481693647.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2cDDgKrhxDwNgUq_yg_=v0YKXhHWBVugfg4Wy6UKOuNcA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> Have you followed all the steps?
> - stop rsyslog
> - delete imjournal.state
> - run kmsg01 couple times
> - run syslog01

Finally, I run more times for ksm01 to make a large backlog of
messages then reproduced it. After applying your patch, the problem
does not appear anymore.  So, ACK for this patch.

---------- Reproduce Log -----------
# cat runtest/wangli
kmsg01 kmsg01
kmsg01 kmsg01
kmsg01 kmsg01
kmsg01 kmsg01
kmsg01 kmsg01
syslog01 syslog01

# systemctl stop rsyslog; rm -fr /var/lib/rsyslog/*; ./runltp -f wangli
syslog01 FAIL

# journalctl
...
Jul 31 04:53:18 hp-dl385pg8-11.rhts.eng.pek2.redhat.com
rsyslogd[3336]: imjournal from <hp-dl385pg8-11:restraintd>: begin to
drop messages due to rate-limiting
Jul 31 04:53:19 hp-dl385pg8-11.rhts.eng.pek2.redhat.com
syslogtst[3341]: syslogtst: mail info test.
Jul 31 04:53:21 hp-dl385pg8-11.rhts.eng.pek2.redhat.com systemd[1]:
Stopping System Logging Service...
Jul 31 04:53:21 hp-dl385pg8-11.rhts.eng.pek2.redhat.com
rsyslogd[3336]: imjournal: 63528 messages lost due to rate-limiting

-- 
Regards,
Li Wang
