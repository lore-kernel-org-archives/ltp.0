From: Punit Agrawal <punit.agrawal@arm.com>
Date: Tue, 10 Jul 2018 15:34:44 +0100
Subject: [LTP] [PATCH] acl_test01: Add setfacl as an explicit dependency
In-Reply-To: <690628691.31612421.1531230835933.JavaMail.zimbra@redhat.com>
 (Jan Stancek's message of "Tue, 10 Jul 2018 09:53:55 -0400")
References: <20180706152927.26646-1-punit.agrawal@arm.com>
 <690628691.31612421.1531230835933.JavaMail.zimbra@redhat.com>
Message-ID: <87muuzp3az.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Jan Stancek <jstancek@redhat.com> writes:

> ----- Original Message -----
>> acl_test01 calls setfacl during execution but does not explicitly
>> check for its presence during setup.
>> 
>> Add this dependency to correctly report the failure mode when setfacl
>> is not found.
>> 
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>
> Pushed.

Thanks!

Since sending this commit I've hit other tests which don't do a full
dependency check - many of them seem to be using 'killall'. I'll try and
collect all the patches and send them out together.

>
> Thanks,
> Jan
