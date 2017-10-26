From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 26 Oct 2017 15:57:25 +0300
Subject: [LTP] [RFC PATCH 1/7] net/tcp_cmds: Remove rwho test
In-Reply-To: <20171026083615.g2nwz4kkf27z3h2d@dell5510>
References: <20171018135001.30382-1-pvorel@suse.cz>
 <20171018135001.30382-2-pvorel@suse.cz>
 <2b595bc0-c7be-782f-9592-da206498f84a@oracle.com>
 <20171026083615.g2nwz4kkf27z3h2d@dell5510>
Message-ID: <ba581b16-797f-be55-03f6-4fe631588a7c@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/26/2017 11:36 AM, Petr Vorel wrote:
> ...
> Please if you agree with other tests to be deleted, ack it.
> I'd be for deleting at least finger, echo, rlogin and rdist, as Vapier asked for keeping rcp
> and rsh. IMHO these project should test their code themselves, I'd prefer LTP concern more
> about the Linux kernel itself, not about *anything* it runs on linux distribution
> (including networking).

By running those tests youare also verifying kernel TCP stack and
network drivers.

Looking at rlogin, it's the only one among them which is convertedto
newer API
already, let's keep it along with the rcp, rsh, they are inthe same
packages.

Acked the rest. I guess we should also change default network
configuration to SSH.

Best regards,
Alexey

