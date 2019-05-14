From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 May 2019 16:30:45 +0200
Subject: [LTP] [PATCH v2 2/2] libltpnuma: remove restrictions on numa
 node-id
In-Reply-To: <20190509064535.GA6096@dhcp-9-109-247-167.in.ibm.com>
References: <20190508084447.18191-1-liwang@redhat.com>
 <20190508084447.18191-2-liwang@redhat.com>
 <20190509064535.GA6096@dhcp-9-109-247-167.in.ibm.com>
Message-ID: <20190514143045.GD1516@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It is better to have check for powerpc and remove restriction as it will
> still hold good for other arch.

I would like to avoid adding arch specific ifdefs to the code, so for
the release I've commited the original fix and we can add better checks
later on. As I wrote checking that the numa id is <= than maximal used
id would be much better and would work in all cases.

-- 
Cyril Hrubis
chrubis@suse.cz
