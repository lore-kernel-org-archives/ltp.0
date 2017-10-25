From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 25 Oct 2017 18:16:54 +0300
Subject: [LTP] [RFC PATCH 1/7] net/tcp_cmds: Remove rwho test
In-Reply-To: <20171018135001.30382-2-pvorel@suse.cz>
References: <20171018135001.30382-1-pvorel@suse.cz>
 <20171018135001.30382-2-pvorel@suse.cz>
Message-ID: <2b595bc0-c7be-782f-9592-da206498f84a@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/18/2017 04:49 PM, Petr Vorel wrote:
> rwhod daemon is way too old to bother to test it.

As far as I remember, another problem with this test is that it's not
really applicable for automated runs because rwho requires someone to
be logged in to the machine for about 2 min to make it pass.

I'm ok with removing it.

Thanks,
Alexey

