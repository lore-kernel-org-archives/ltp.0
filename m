From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 4 Apr 2018 16:04:21 +0300
Subject: [LTP] [PATCH v2] sctp/sctp_big_chunk.c: Fix compiler error
In-Reply-To: <1522840374-10311-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <fe226cc4-3c0a-0b4b-e618-e31e28647d07@oracle.com>
 <1522840374-10311-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <cecc4bb1-d78b-a5d5-20f2-ae66407056eb@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On 04.04.2018 14:12, Xiao Yang wrote:
> On old distros(e.g. RHEL5), Compilation failed because of redefinitions
> from linux/sctp.h(including linux/in.h) and netinet/in.h, as below:
> ----------------------------------------------------------------------
> In file included from /usr/include/linux/sctp.h:54,
>                  from ../../../include/lapi/sctp.h:22,
>                  from sctp_big_chunk.c:35:
> /usr/include/linux/in.h:26: error: redeclaration of enumerator ‘IPPROTO_IP’
> /usr/include/netinet/in.h:33: error: previous definition of ‘IPPROTO_IP’ was here
> ...
> ----------------------------------------------------------------------
> 
> 1) Remove the include of linux/sctp.h to fix it.
> 2) Include netinet/sctp.h, if it was available.
> 

Applied, thanks!
