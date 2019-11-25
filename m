From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 25 Nov 2019 09:54:02 -0500 (EST)
Subject: [LTP] [PATCH v2 2/3] perf_event_open02: make do_work() run for
 specified time
In-Reply-To: <20191122133343.GD19146@rei.lan>
References: <5b0f2a837117f3af1351d8b3da357cacecaa1463.1574087532.git.jstancek@redhat.com>
 <219b1b89de51fda28a0af02f6b15e6da8c73ab7c.1574363475.git.jstancek@redhat.com>
 <20191122133343.GD19146@rei.lan>
Message-ID: <327090990.13706910.1574693642661.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> > 
> > Tested with: 5.3.0-0.rc6.git0.1.fc31.x86_64
> > 	     4.18.0-143.el8.x86_64
> > 	     4.18.0-147.rt24.93.el8.x86_64
> 
> Looks good, acked.

Series pushed.

I tested also older kernels based on 2.6.32 (RHEL6.10), and recently
released 5.4.

