From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 20 Jan 2017 18:47:47 +0300
Subject: [LTP] [PATCH] network: fix export for some non-bash shells
In-Reply-To: <20170119174016.3jkpnexon6t4s2y5@x230>
References: <20161219125407.15954-1-pvorel@suse.cz>
 <20170119174016.3jkpnexon6t4s2y5@x230>
Message-ID: <61b75b72-7f77-f7cb-188c-822a01b22b73@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01/19/2017 08:40 PM, Petr Vorel wrote:
> how about this one? It breaks system with dash as default shell (i.e. at least Debian,
> Ubuntu and derivates).
>
> Actually I'd be for replacing all exports, as nothing with spaces will not work in dash (I
> know we don't support fixes for spaces in PATH, but this is something different):
Hi Petr,

Agree, please send a patch.

Thanks,
Alexey

