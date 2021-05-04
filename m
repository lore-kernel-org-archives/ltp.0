From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  4 May 2021 21:02:35 +0200
Subject: [LTP] [PATCH v2 0/5] docparser formatting improvements
Message-ID: <20210504190240.24250-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

originally there was only commit "docparse: Make tags in table
clickable".
I added few more formatting changes. Most important is to filter by
.tags keys.

Kind regards,
Petr

Petr Vorel (5):
  docparse: Move CVE and git link into Info column
  docparse: Filter .tags by key
  docparse: Make tags in table clickable
  docparse: Sort alphabetically tags in table
  docparse: Fix headers

 docparse/testinfo.pl | 92 +++++++++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 30 deletions(-)

-- 
2.31.1

