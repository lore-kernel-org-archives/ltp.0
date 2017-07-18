From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 Jul 2017 14:12:23 +0200
Subject: [LTP] [RFC PATCH v6 09/11] network/stress: Fix and cleanup
 route IPv4 tests
In-Reply-To: <fa66bd09-d7a3-d609-7213-c3adb7e08218@oracle.com>
References: <20170603120022.13415-1-pvorel@suse.cz>
 <20170603120022.13415-10-pvorel@suse.cz>
 <bf219efe-a926-aa08-c24c-376fc4676556@oracle.com>
 <20170627060404.mcj3jzq6mq3bfuja@dell5510>
 <fa66bd09-d7a3-d609-7213-c3adb7e08218@oracle.com>
Message-ID: <20170718121223.xpy2mhkcer7ctdxe@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,
> Hi Petr,

> Right, the usage of 'initialize_if' is replaced in route4 patch, so
> the question was why we need this change in 'initialize_if' here?

Thank you for your comment. But please don't spend your time with reviewing v6. I'm
finishing v7, where I did more radical cleanup (I got inspiration with your interface
tests - if-lib.sh).
ATM I'm fixing issues for SSH based testing (previously I run it only with netns, some
things got broken).


Kind regards,
Petr
