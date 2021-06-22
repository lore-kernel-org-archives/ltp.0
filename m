From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 22 Jun 2021 18:17:37 +0200
Subject: [LTP] [PATCH] tst_rtnetlink: pass error codes using rtnl_errno
 variable
In-Reply-To: <871r8t6frr.fsf@suse.de>
References: <20210622154804.19946-1-mdoucha@suse.cz> <871r8t6frr.fsf@suse.de>
Message-ID: <912a58e4-3c05-4de0-6346-7cfa80f6fbd4@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 22. 06. 21 18:11, Richard Palethorpe wrote:
> Hello Martin,
> 
> Martin Doucha <mdoucha@suse.cz> writes:
>> +extern int rtnl_errno;
> 
> This is polluting the name space. I suppose it can be prepended
> with tst_, but does the test author need to see this? Or you could even
> just merge tst_netdevice and tst_rtnetlink.
> 
> Otherwise I think this approach is fine.

You're right, I should have prefixed it with tst_. I'll send v2 in a moment.

Yes, test authors will need to access this variable if they want to use
RTNL_CHECK_ACKS() or RTNL_SEND_VALIDATE() in their tests.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
