From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 Feb 2019 00:21:40 +0100
Subject: [LTP] [PATCH 1/4] netstress: support SO_REUSEPORT with new 'P'
 flag
In-Reply-To: <1549908467-15609-2-git-send-email-alexey.kodanev@oracle.com>
References: <1549908467-15609-1-git-send-email-alexey.kodanev@oracle.com>
 <1549908467-15609-2-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20190214232140.GA12954@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> netstress tool can be used manually by setting -P flag for
> a server. There is no test-case yet that specifically
> auto tests this functionality or uses it, but it should be
> easy to create one. For example, starting multiple netstress
> instances on the same port.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>


Kind regards,
Petr
