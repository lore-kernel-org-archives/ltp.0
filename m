From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 20 Mar 2019 08:24:37 -0400 (EDT)
Subject: [LTP] [PATCH RFC] perf_event_open02: check if
 PERF_COUNT_HW_INSTRUCTIONS is supported
In-Reply-To: <20190312135423.55451d38@TP-holzheu>
References: <20190312053236.10172-1-liwang@redhat.com>
 <20190312135423.55451d38@TP-holzheu>
Message-ID: <1020476837.10530283.1553084677600.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Looks good to me.
> 
> Reviewed-by: Michael Holzheu <holzheu@linux.ibm.com>
> 
> Am Tue, 12 Mar 2019 13:32:36 +0800
> schrieb Li Wang <liwang@redhat.com>:
> 
> > The testcase is broken on system with PERF_COUNT_HW_INSTRUCTIONS not
> > supported.
> > Previously, it does the event check in count_hardware_counters, but that
> > has
> > been filtered out on s390 platform via commit 6730475ba5. So now test break
> > as follow:
> >   perf_event_open02    1  TBROK  :  perf_event_open02.c:275:
> >   perf_event_open failed: errno=ENOENT(2): No such file or directory
> >   perf_event_open02    2  TBROK  :  perf_event_open02.c:275: Remaining
> >   cases broken
> > 
> > Signed-off-by: Li Wang <liwang@redhat.com>

Pushed.

Thanks,
Jan
