From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 30 May 2016 06:20:01 -0400 (EDT)
Subject: [LTP] cgroup_regression_test failed in CentOS 7.2
In-Reply-To: <CAAUgArA4ON_uT+nTEPqret4o51CaaXehopnoh+HdmMUdN_RKQw@mail.gmail.com>
References: <CAAUgArA3oBMmf4YJebREKXYyE_XfQnsw3_eO1gV-K_b8FaKnFg@mail.gmail.com>
 <2095793802.2123498.1464345325799.JavaMail.zimbra@redhat.com>
 <CAAUgArA4ON_uT+nTEPqret4o51CaaXehopnoh+HdmMUdN_RKQw@mail.gmail.com>
Message-ID: <1645453180.4039769.1464603601845.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Dong ZHu" <bluezhudong@gmail.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Friday, 27 May, 2016 4:08:49 PM
> Subject: Re: [LTP] cgroup_regression_test failed in CentOS 7.2
> 
> Hi Jan,
> 
> Thanks for your info, Is there any effective way (any options or
> workaround) for making the test passing on systemd distros ?

I think you could configure systemd to mount cpu and cpuacct
separately, but that may break other cgroup tests that mount 2+
subsystems together. Test should be fixed to expect that some
subsystems are mounted already or at least skip the parts
(as TCONF) where we know mount can't succeed.

Regards,
Jan
