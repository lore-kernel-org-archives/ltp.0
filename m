From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 7 Feb 2020 10:56:46 -0500 (EST)
Subject: [LTP] [PATCH v6 1/2] safe_macros: Use tst_umount() in
 safe_umount()
In-Reply-To: <20200207155324.GA21543@dell5510>
References: <20200207144105.19947-1-pvorel@suse.cz>
 <20200207152406.GA16951@rei.lan>
 <285421765.6549099.1581090469387.JavaMail.zimbra@redhat.com>
 <20200207155324.GA21543@dell5510>
Message-ID: <166619231.6550604.1581091006706.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi,
> 
> > > My expectation is that retrying on EBUSY will not break anything. Jan
> > > what do you think?
> 
> > I agree. Though I'd like to point out that tst_umount() currently loops
> > on any error, not just EBUSY.
> 
> I suggest to give it a try and if problematic, we change it to EBUSY.
> Ack?

Ack.

