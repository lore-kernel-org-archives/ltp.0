Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2A6C02196
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 14:37:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70F313C9277
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 15:37:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43EAC3C9296
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:34:52 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7FF7E141ECC0
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:34:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0BC6E21166;
 Thu,  6 Feb 2025 14:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738852488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vx0z7yFEkyvkT5Doed5dDvnQhNKWmKxXQraLdTu0YlY=;
 b=0HorWK+xLX1sUfrbHmFkVgjCghvVjQWbX8xzdS1kCIJ3iDOTBzuTWP0YIWfXKbjzaOsiFs
 OKFB1EBwHw8R1XXYXzyJCBUTHF+ISzYGt6LSKTajDkDz3zgM8ZB3nCJTAakkcFhFndG+Pt
 +ILAiOxF7PGAhQlS3yGdjQW6OroVcA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738852488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vx0z7yFEkyvkT5Doed5dDvnQhNKWmKxXQraLdTu0YlY=;
 b=fqdPHRZc8mCsDDM9ptcx8M2TTTLIFuNOxK+3gQzKX+R+Ib5wZup+UqJ2HuLe8LpeW/uoNu
 0V54NW2kpO6DBLDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738852487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vx0z7yFEkyvkT5Doed5dDvnQhNKWmKxXQraLdTu0YlY=;
 b=bX1uIgVn1Xn+2TfYwlVkp3s2We2JkW/Am4fTvJiL3njZlqU6nTTI94RV/q4hAQyENfcXnN
 +vyEkk1vXWBBcjfsePhWaAfaPIxO/2xIOD/CuaoGyfKKZEm42PirBB2o+mkyniYt3z4+gr
 vcLmg0RrbdR5qAIFyDeI+F2vQV+5DlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738852487;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vx0z7yFEkyvkT5Doed5dDvnQhNKWmKxXQraLdTu0YlY=;
 b=30SYG4W/z1JF5cat0ZzmGkhCupmI2Zhc9du5gvr4qDQAq5OE2dSvVvb2LpkSSzhBbnZuFj
 Ol8qYQwFHPffGSCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA24E13694;
 Thu,  6 Feb 2025 14:34:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4M7pL4bIpGfvJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Feb 2025 14:34:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  6 Feb 2025 15:34:20 +0100
Message-ID: <20250206143421.1571918-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250206143421.1571918-1-pvorel@suse.cz>
References: <20250206143421.1571918-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/7] configure: make: Add SPDX, update copyright
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add SPDX and copyright to few missing places or update copyright.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac                        |  3 +++
 doc/Makefile                        |  3 +++
 include/mk/automake.mk              | 24 ++++--------------------
 include/mk/config-openposix.mk.in   |  2 ++
 include/mk/config.mk.in             | 23 +++--------------------
 include/mk/env_post.mk              | 25 ++++---------------------
 include/mk/env_pre.mk               | 26 ++++----------------------
 include/mk/features.mk.in           | 22 ++--------------------
 include/mk/functions.mk             | 25 ++++---------------------
 include/mk/generic_leaf_target.inc  | 24 ++++--------------------
 include/mk/generic_leaf_target.mk   | 24 ++++--------------------
 include/mk/generic_trunk_target.inc | 24 ++++--------------------
 include/mk/generic_trunk_target.mk  | 24 ++++--------------------
 include/mk/lib.mk                   | 27 ++++-----------------------
 include/mk/man.mk                   | 23 +++--------------------
 include/mk/module.mk                | 18 ++----------------
 include/mk/rules.mk                 |  3 +++
 include/mk/sparse.mk                |  2 ++
 include/mk/testcases.mk             | 22 ++--------------------
 19 files changed, 61 insertions(+), 283 deletions(-)

diff --git a/configure.ac b/configure.ac
index afcbd1a5ef..c663108a8d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,3 +1,6 @@
+# Copyright (c) Linux Test Project, 2008-2025
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 AC_PREREQ(2.64)
 AC_INIT([ltp], [LTP_VERSION], [ltp@lists.linux.it])
 AC_CONFIG_AUX_DIR([.])
diff --git a/doc/Makefile b/doc/Makefile
index 0f67721ef5..c6dadfd521 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -1,3 +1,6 @@
+# Copyright (c) Linux Test Project, 2024-2025
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 PYTHON := python3
 
 # install sphinx only if needed
diff --git a/include/mk/automake.mk b/include/mk/automake.mk
index 0fa059f117..79f83a5a2e 100644
--- a/include/mk/automake.mk
+++ b/include/mk/automake.mk
@@ -1,24 +1,8 @@
-#
-#    Autotools include Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Autotools include Makefile.
+# Copyright (c) Linux Test Project, 2010-2024
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#
 
 # Override these variables to use non-system available tools.
 ACLOCAL		?= aclocal
diff --git a/include/mk/config-openposix.mk.in b/include/mk/config-openposix.mk.in
index 9a91dcb7ee..54422aec1b 100644
--- a/include/mk/config-openposix.mk.in
+++ b/include/mk/config-openposix.mk.in
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2016
 # Parameters from the top level configure
 CC=		@CC@
 CFLAGS+=	@CFLAGS@
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index f6e02eaeba..baf1b414ec 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -1,24 +1,7 @@
-#
-#    config.mk.in.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2009-2024
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#
 
 # See this page for more info about LEX*:
 # http://www.gnu.org/software/hello/manual/autoconf/Particular-Programs.html
diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index 4dd3f1e2d7..ab31da73af 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -1,25 +1,8 @@
-#
-#    Environment post-setup Makefile.
-#
-#    Copyright (c) Linux Test Project, 2009-2020
-#    Copyright (c) Cisco Systems Inc., 2009
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Environment post-setup Makefile.
+# Copyright (c) Linux Test Project, 2009-2025
+# Copyright (c) Cisco Systems Inc., 2009
 # Ngie Cooper, July 2009
-#
 
 ENV_PRE_LOADED			?= $(error You must load env_pre.mk before including this file)
 
diff --git a/include/mk/env_pre.mk b/include/mk/env_pre.mk
index f362151675..46d6abecfb 100644
--- a/include/mk/env_pre.mk
+++ b/include/mk/env_pre.mk
@@ -1,29 +1,11 @@
-#
-#    Make pre-include environment Makefile.
-#
-#    Copyright (c) Linux Test Project, 2009-2020
-#    Copyright (c) Cisco Systems Inc., 2009
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Make pre-include environment Makefile.
+# Copyright (c) Linux Test Project, 2009-2020
+# Copyright (c) Cisco Systems Inc., 2009
 # Ngie Cooper, September 2009
 #
 # This Makefile must be included first. NO IF'S, AND'S, OR BUT'S.
-#
 # This sets the stage for all operations required within Makefiles.
-#
 
 ifndef ENV_PRE_LOADED
 ENV_PRE_LOADED = 1
diff --git a/include/mk/features.mk.in b/include/mk/features.mk.in
index 0a8a405acf..3af74002b6 100644
--- a/include/mk/features.mk.in
+++ b/include/mk/features.mk.in
@@ -1,24 +1,6 @@
-#
-#    features.mk.in - feature tuning include Makefile.
-#
-#    Copyright (C) 2010, Linux Test Project.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# Copyright (c) Linux Test Project, 2008-2025
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Ngie Cooper, October 2010
-#
 
 # Tools enable knobs
 WITH_EXPECT			:= @WITH_EXPECT@
diff --git a/include/mk/functions.mk b/include/mk/functions.mk
index e86dbccdc0..60dbed395e 100644
--- a/include/mk/functions.mk
+++ b/include/mk/functions.mk
@@ -1,25 +1,8 @@
-#
-#  A Makefile with a collection of reusable functions.
-#
-#    Copyright (c) Linux Test Project, 2009-2020
-#    Copyright (c) Cisco Systems Inc., 2009
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# A Makefile with a collection of reusable functions.
+# Copyright (c) Linux Test Project, 2009-2020
+# Copyright (c) Cisco Systems Inc., 2009
 # Ngie Cooper, July 2009
-#
 
 # Generate an install rule which also creates the install directory if needed
 # to avoid unnecessary bourne shell based for-loops and install errors, as well
diff --git a/include/mk/generic_leaf_target.inc b/include/mk/generic_leaf_target.inc
index 565a282bb3..7c685fea76 100644
--- a/include/mk/generic_leaf_target.inc
+++ b/include/mk/generic_leaf_target.inc
@@ -1,24 +1,8 @@
-#
-#    Generic leaf rules include Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Generic leaf rules include Makefile.
+# Copyright (c) Linux Test Project, 2017-2022
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#
 
 #
 # generic_leaf_target
diff --git a/include/mk/generic_leaf_target.mk b/include/mk/generic_leaf_target.mk
index 908d0b0004..c200803b55 100644
--- a/include/mk/generic_leaf_target.mk
+++ b/include/mk/generic_leaf_target.mk
@@ -1,24 +1,8 @@
-#
-#    Generic leaf include Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Generic leaf include Makefile.
+# Copyright (c) Linux Test Project, 2017
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#
 
 include $(top_srcdir)/include/mk/env_post.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.inc
diff --git a/include/mk/generic_trunk_target.inc b/include/mk/generic_trunk_target.inc
index 82aece7c02..f9db7896a9 100644
--- a/include/mk/generic_trunk_target.inc
+++ b/include/mk/generic_trunk_target.inc
@@ -1,24 +1,8 @@
-#
-#    Generic trunk rules include Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2010-2021
+# Generic trunk rules include Makefile.
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#
 
 #
 # generic_trunk_target
diff --git a/include/mk/generic_trunk_target.mk b/include/mk/generic_trunk_target.mk
index 576b32db39..e25f7bce24 100644
--- a/include/mk/generic_trunk_target.mk
+++ b/include/mk/generic_trunk_target.mk
@@ -1,24 +1,8 @@
-#
-#    Generic trunk include Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Generic trunk include Makefile.
+# Copyright (c) Linux Test Project, 2017
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#
 
 include $(top_srcdir)/include/mk/env_post.mk
 include $(top_srcdir)/include/mk/generic_trunk_target.inc
diff --git a/include/mk/lib.mk b/include/mk/lib.mk
index 3bf63bf9e8..cefb28c25d 100644
--- a/include/mk/lib.mk
+++ b/include/mk/lib.mk
@@ -1,27 +1,8 @@
-#
-#    library include Makefile.
-#
-#    Copyright (c) Linux Test Project, 2009-2020
-#    Copyright (c) Cisco Systems Inc., 2009
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2009-2019
 # Copyright (C) Cyril Hrubis <chrubis@suse.cz> 2012
-#
+# Copyright (c) Cisco Systems Inc., 2009
+# Ngie Cooper, July 2009
 
 # Makefile to include for libraries.
 
diff --git a/include/mk/man.mk b/include/mk/man.mk
index c94af61b11..a642dfb35d 100644
--- a/include/mk/man.mk
+++ b/include/mk/man.mk
@@ -1,24 +1,7 @@
-#
-#    Manpage include Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2010-2017
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#
 
 ifeq ($(strip $(MANPREFIX)),)
 $(error $$(MANPREFIX) not defined)
diff --git a/include/mk/module.mk b/include/mk/module.mk
index 3bb7350f1e..10914084cf 100644
--- a/include/mk/module.mk
+++ b/include/mk/module.mk
@@ -1,24 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# Copyright (c) Linux Test Project, 2014-2021
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Include it to build kernel modules.
 # REQ_VERSION_MAJOR and REQ_VERSION_PATCH must be defined beforehand.
-#
 
 $(if $(REQ_VERSION_MAJOR),,$(error You must define REQ_VERSION_MAJOR))
 $(if $(REQ_VERSION_PATCH),,$(error You must define REQ_VERSION_MINOR))
diff --git a/include/mk/rules.mk b/include/mk/rules.mk
index 517863c04b..c7da6d37f9 100644
--- a/include/mk/rules.mk
+++ b/include/mk/rules.mk
@@ -1,3 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2020-2022
+
 target_rel_dir := $(if $(cwd_rel_from_top),$(cwd_rel_from_top)/,)
 
 %.o: %.S
diff --git a/include/mk/sparse.mk b/include/mk/sparse.mk
index a86928393a..3390672c15 100644
--- a/include/mk/sparse.mk
+++ b/include/mk/sparse.mk
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2021
 # Rules to make sparse tool(s) for inclusion in lib and testcases Makefiles
 
 SPARSE_DIR:= $(abs_top_builddir)/tools/sparse
diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index bec8d8cc47..2609535ce7 100644
--- a/include/mk/testcases.mk
+++ b/include/mk/testcases.mk
@@ -1,24 +1,6 @@
-#
-#    testcases include Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2009-2024
 # Ngie Cooper, July 2009
-#
 
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(top_srcdir)/include/mk/functions.mk
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
