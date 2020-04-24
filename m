From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 24 Apr 2020 11:27:43 -0400 (EDT)
Subject: [LTP] [PATCH v2] Add test for CVE 2018-9568
In-Reply-To: <20200416122023.20952-1-mdoucha@suse.cz>
References: <20200416122023.20952-1-mdoucha@suse.cz>
Message-ID: <1316682995.10143512.1587742063487.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

fyi, some kernels may hit TBROK because commit b6f6118901d1
("ipv6: restrict IPV6_ADDRFORM operation") broke IPV6_ADDRFORM:
  https://lkml.org/lkml/2020/4/18/574

