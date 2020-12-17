From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Dec 2020 13:15:18 +0100
Subject: [LTP] [PATCH 0/2] Travis build fixes
Message-ID: <20201217121520.25713-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

FYI only first commit is required to fix travis failures.

Kind regards,
Petr

Petr Vorel (2):
  docparse/parse.sh: Fix parsing on dash
  docparse/parse.sh: Fix running with relative path

 docparse/parse.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.29.2

