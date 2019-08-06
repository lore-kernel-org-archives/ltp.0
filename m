From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 6 Aug 2019 07:17:05 -0400 (EDT)
Subject: [LTP] [PATCH] syslog: fix sporadic failures due to
 rate-limitting
In-Reply-To: <CAEemH2cDDgKrhxDwNgUq_yg_=v0YKXhHWBVugfg4Wy6UKOuNcA@mail.gmail.com>
References: <6db4a928733290dca3b2e4b4a27f1cb69d805401.1563959090.git.jstancek@redhat.com>
 <CAEemH2dqE8Ad_r+vnrd0BnBoyOO9GTLoE20SPSQtV7mbr-Yabg@mail.gmail.com>
 <1049532097.3289438.1564481693647.JavaMail.zimbra@redhat.com>
 <CAEemH2cDDgKrhxDwNgUq_yg_=v0YKXhHWBVugfg4Wy6UKOuNcA@mail.gmail.com>
Message-ID: <23449784.4890660.1565090225268.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan,
> 
> > Have you followed all the steps?
> > - stop rsyslog
> > - delete imjournal.state
> > - run kmsg01 couple times
> > - run syslog01
> 
> Finally, I run more times for ksm01 to make a large backlog of
> messages then reproduced it. After applying your patch, the problem
> does not appear anymore.  So, ACK for this patch.

Pushed.

Thanks,
Jan
