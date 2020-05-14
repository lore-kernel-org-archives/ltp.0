From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 May 2020 20:49:00 +0200
Subject: [LTP] [PATCH 0/4] Update installation docs
Message-ID: <20200514184904.4537-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I updated installation docs. First motivation was to document pkgconf /
pkg-config related changes. But I also added a cleanup, because
instructions looked like 10+ years old.

I suppose there is nothing controversial with this patchset.

Kind regards,
Petr

Petr Vorel (4):
  INSTALL: Update requirements
  INSTALL: Document 32bit and cross-compilation setup
  INSTALL: Remove uClinux docs
  doc: Remove links to README.mk-devel

 INSTALL                 | 75 +++++++++++++++++++++--------------------
 README.md               |  5 +--
 include/mk/config.mk.in |  2 +-
 3 files changed, 43 insertions(+), 39 deletions(-)

-- 
2.26.2

