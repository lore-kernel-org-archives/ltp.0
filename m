From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 25 Aug 2021 13:43:31 +0200
Subject: [LTP] [PATCH 3/3] Add test for CVE 2021-3609
In-Reply-To: <87k0k9lpld.fsf@suse.de>
References: <20210825104300.15255-1-mdoucha@suse.cz>
 <20210825104300.15255-3-mdoucha@suse.cz> <87k0k9lpld.fsf@suse.de>
Message-ID: <025997b0-e0a8-d450-e387-f1a2e8a720e9@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 25. 08. 21 13:40, Richard Palethorpe wrote:
> Hello Martin,
> 
> I think you dropped NS due to lack of CAN support on older kernels?

Exactly. If I create a new network namespace, SAFE_SOCKET() will fail
with EAFNOSUPPORT on kernel 4.4.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
