From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 14 Sep 2017 14:29:59 +0300
Subject: [LTP] [PATCH v4 1/2] lib6/in6_01: Fix IPv6 addresses which do
 not comply RFC 2373
In-Reply-To: <20170914091306.20147-1-pvorel@suse.cz>
References: <20170914091306.20147-1-pvorel@suse.cz>
Message-ID: <762abba2-47ae-d3d1-dbc8-3d508d48d347@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09/14/2017 12:13 PM, Petr Vorel wrote:
> Hextet 0a001 contains wrong leading zero which makes it invalid.
> glibc 2.26 starts rejecting IPv6 addresses which do not comply RFC 2373.
> Change was made in this commit:

Patch-set applied, thank you!
