From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 12 Jul 2021 10:58:57 +0200
Subject: [LTP] [PATCH v2 1/2] proc01: fix selinux attributes without
 libselinux-dev
In-Reply-To: <20210701131427.72574-1-krzysztof.kozlowski@canonical.com>
References: <20210701131427.72574-1-krzysztof.kozlowski@canonical.com>
Message-ID: <YOwEUbm88x2jom2Y@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> SELinux can be enabled on the system which does not have development
> selinux libraries.  Such case was already done for Smack and Apparmor
> where we unconditionally accept their attribute failures.  Do the same
> for SELinux to fix failures like:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
