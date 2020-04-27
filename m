From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 27 Apr 2020 03:31:22 -0400 (EDT)
Subject: [LTP] [PATCH] Add env variable as workaround for test issues in
 VMs
In-Reply-To: <20200427053125.GA21164@dell5510>
References: <20200424150422.17467-1-mdoucha@suse.cz>
 <20200427053125.GA21164@dell5510>
Message-ID: <951270734.10286613.1587972682386.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Martin,
> 
> > Timer tests often fail on sleep overrun when LTP is running inside a VM.
> > The main cause is usually that the VM doesn't get enough CPU time to wake
> > up
> > the test process in time.
> Cannot we detect presence of "hypervisor" in flags in /proc/cpuinfo?
> I though it was quite reliable for detecting VM.

We have tst_is_virt().

I see these tests fail frequently on ppc and s390, so I'm all for
some switch that would make it more forgiving if running under virt.

