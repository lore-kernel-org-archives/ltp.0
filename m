From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 18 May 2018 12:53:05 +0300
Subject: [LTP] [PATCH 2/2] network/route: Rewrite route-change-gw into
	new API
In-Reply-To: <20180517103527.23542-2-pvorel@suse.cz>
References: <20180517103527.23542-1-pvorel@suse.cz>
 <20180517103527.23542-2-pvorel@suse.cz>
Message-ID: <cfa4f035-9052-147b-4d6d-2b6ecfe4cf31@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 17.05.2018 13:35, Petr Vorel wrote:
> Drop route command (use just ip command), simplify
>

I think the commit message should be more descriptive about the
changes being made... don't remember why the rewritten test is
not using background traffic and not changing gateway anymore?
