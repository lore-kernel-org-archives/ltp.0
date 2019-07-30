From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 30 Jul 2019 06:14:53 -0400 (EDT)
Subject: [LTP] [PATCH] syslog: fix sporadic failures due to
 rate-limitting
In-Reply-To: <CAEemH2dqE8Ad_r+vnrd0BnBoyOO9GTLoE20SPSQtV7mbr-Yabg@mail.gmail.com>
References: <6db4a928733290dca3b2e4b4a27f1cb69d805401.1563959090.git.jstancek@redhat.com>
 <CAEemH2dqE8Ad_r+vnrd0BnBoyOO9GTLoE20SPSQtV7mbr-Yabg@mail.gmail.com>
Message-ID: <1049532097.3289438.1564481693647.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan,
> 
> On Wed, Jul 24, 2019 at 5:07 PM Jan Stancek <jstancek@redhat.com> wrote:
> >
> > Some distros (Fedora30) do not have rsyslog installed by default.
> > Also some test environments generate a lot of messages before they
> > start syslogs tests.
> >
> > This creates a problem if rsyslog is using imjournal, because by default
> > rate-limitting is enabled. If there is a big backlog of messages
> > prior to running syslog tests, some messages from tests may be dropped.
> 
> I'm not sure if I understand this situation, from your description, if
> the rsyslog is not installed,

OK, that might be specific to our harness. We install rsyslog before LTP runs.
My point was that rsyslog wasn't running when system started, and therefore
the backlog kept on growing.

> then the /etc/rsyslog.conf will not exist, so how does the rsyslog
> using imjournal to effect on the test cases? Shouldn't it choose
> syslog or syslog-ng for testing?
> 
> if [ "$SYSLOG_DAEMON" = "syslog" ]; then
>         CONFIG_FILE="/etc/syslog.conf"
> elif [ "$SYSLOG_DAEMON" = "syslog-ng" ]; then
>         CONFIG_FILE="/etc/syslog-ng/syslog-ng.conf"
> elif [ "$SYSLOG_DAEMON" = "rsyslog" ]; then
>         ....
> fi
> 
> And from my test, if I remove(#rpm -e rsyslog) the rsyslog from
> system, this test will choose to go
> syslog-ng(/etc/syslog-ng/syslog-ng.conf) way to test. unfoutananly
> that always failed as:
> 
> --------------------------
> syslog02    0  TINFO  :  Test if messages of all levels are logged.
> syslog02    0  TINFO  :  For each level, a separate configuration file is
> syslog02    0  TINFO  :  created and that will be used as syslog.conf file.
> syslog02    0  TINFO  :  testing whether messages are logged into log file
> syslog02    0  TINFO  :  Doing level: emerg...
> syslog02    0  TINFO  :  restarting syslog daemon
> Broadcast message from
> systemd-journald@intel-chiefriver-02.khw2.lab.eng.bos.redhat.com (Tue
> 2019-07-30 09:42:24 EDT):
> syslogtst[26081]: syslogtst: mail emerg test.
> syslog02    1  TFAIL  :  ltpapicmd.c:188: ***** Level emerg failed *****
> syslog02    0  TINFO  :  Doing level: alert...
> syslog02    0  TINFO  :  restarting syslog daemon
> syslog02    2  TFAIL  :  ltpapicmd.c:188: ***** Level alert failed *****
> syslog02    0  TINFO  :  Doing level: crit...
> syslog02    0  TINFO  :  restarting syslog daemon
> syslog02    3  TFAIL  :  ltpapicmd.c:188: ***** Level crit failed *****
> syslog02    0  TINFO  :  Doing level: err...
> syslog02    0  TINFO  :  restarting syslog daemon
> syslog02    4  TFAIL  :  ltpapicmd.c:188: ***** Level err failed *****
> syslog02    0  TINFO  :  Doing level: warning...
> syslog02    0  TINFO  :  restarting syslog daemon
> syslog02    5  TFAIL  :  ltpapicmd.c:188: ***** Level warning failed *****
> syslog02    0  TINFO  :  Doing level: notice...
> syslog02    0  TINFO  :  restarting syslog daemon
> syslog02    6  TFAIL  :  ltpapicmd.c:188: ***** Level notice failed *****
> syslog02    0  TINFO  :  Doing level: info...
> syslog02    0  TINFO  :  restarting syslog daemon
> syslog02    7  TFAIL  :  ltpapicmd.c:188: ***** Level info failed *****
> syslog02    0  TINFO  :  Doing level: debug...
> syslog02    0  TINFO  :  restarting syslog daemon
> syslog02    8  TFAIL  :  ltpapicmd.c:188: ***** Level debug failed *****
> syslog02    0  TINFO  :  restarting syslog daemon
> 
> > Easy way to reproduce is to stop rsyslog, delete imjournal.state,
> > run kmsg01 test couple times and then run some syslog test:
> >   Jul 23 15:05:13 ... begin to drop messages due to rate-limiting
> >   Jul 23 15:05:21 ... 47006 messages lost due to rate-limiting
> > Messages make it to systemd journal, but not to log configured in rsyslog.
> 
> I didn't reproduce this problem, if I stop rsyslog(`systemctl stop
> rsyslog`) by manual, the test will enable it automatically:
> 
> ---------------------
> syslog02    0  TINFO  :  restarting syslog daemon
> ...
> syslogtst[26848]: syslogtst: mail emerg test.
> syslog02    1  TPASS  :  ***** Level emerg passed *****
> ------------------------
> 
> or maybe I missed something?

Have you followed all the steps?
- stop rsyslog
- delete imjournal.state
- run kmsg01 couple times
- run syslog01

> 
> --
> Regards,
> Li Wang
> 
