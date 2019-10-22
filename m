From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 22 Oct 2019 03:10:23 -0400 (EDT)
Subject: [LTP] [PATCH] lsmod01.sh: retry test couple times to lower
 false positives
In-Reply-To: <20191018134525.GA2589@dell5510>
References: <c8843f2f4a325e820d030d9c7c36d7624f1baa82.1571393044.git.jstancek@redhat.com>
 <20191018134525.GA2589@dell5510>
Message-ID: <1931638600.8070217.1571728223473.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan,
> 
> ...
> >  	if [ "$lsmod_output" != "$modules_output" ]; then
> > -		tst_res TFAIL "lsmod output different from /proc/modules."
> > +		tst_res TINFO "lsmod output different from /proc/modules."
> 
> >  		echo "$lsmod_output" > temp1
> >  		echo "$modules_output" > temp2
> >  		diff temp1 temp2
> Also this code could be wrapped with
> if tst_cmd_available diff; then

Added this as well and pushed.

