From: Hangbin Liu <haliu@redhat.com>
Date: Tue, 15 Mar 2016 17:41:07 +0800
Subject: [LTP] [PATCH 3/3] network/stress/icmp: use ip xfrm for
 icmp4-uni-basic01 ipsec testing
In-Reply-To: <56E66959.3030305@oracle.com>
References: <1457334883-11086-1-git-send-email-haliu@redhat.com>
 <1457334883-11086-4-git-send-email-haliu@redhat.com>
 <56E01CDE.9090101@oracle.com>
 <20160310065045.GM2649@Leo.nay.redhat.com>
 <56E122F6.9060504@oracle.com>
 <20160311030836.GP2649@Leo.nay.redhat.com>
 <56E2AED0.3050605@oracle.com>
 <20160311143327.GT2649@Leo.nay.redhat.com>
 <56E66959.3030305@oracle.com>
Message-ID: <20160315094107.GB29634@Leo.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Mar 14, 2016 at 10:33:45AM +0300, Alexey Kodanev wrote:
> >Hmm, looks multi-diffnic could use this method since it only has ${link_num}
> >subnets, but multi-diffip test use two dimension subnets. which looks like
> >client: 10.${x}.${y}.1 , server: 10.${x}.${y}.2 . So I think we could not use
> >like local new_ip=${IPV4_NET16_UNUSED}.$x.$y
> 
> We can create 16K subnets with $IPV4_NET16_UNUSED.$x.$y/30 that each can
> have
> two hosts. Is it not enough for the test? I see diffip01 test set only
> 100 IP pairs (subnets) for default.

Hi Alexey,

Yes, this way is good. I will do as you said when update multi-ip/nic test
cases.

Thanks
Hangbin
