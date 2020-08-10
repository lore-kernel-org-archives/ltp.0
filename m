From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 10 Aug 2020 04:17:53 -0400 (EDT)
Subject: [LTP] [PATCH] Add test for CVE-2019-8912
In-Reply-To: <20200806142334.30494-1-mdoucha@suse.cz>
References: <20200806142334.30494-1-mdoucha@suse.cz>
Message-ID: <754283726.7180369.1597047473774.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Fixes #504
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  runtest/crypto                     |   1 +
>  runtest/cve                        |   1 +
>  testcases/kernel/crypto/.gitignore |   1 +
>  testcases/kernel/crypto/Makefile   |   4 +-
>  testcases/kernel/crypto/af_alg07.c | 117 +++++++++++++++++++++++++++++
>  5 files changed, 122 insertions(+), 2 deletions(-)
>  create mode 100644 testcases/kernel/crypto/af_alg07.c

Acked-by: Jan Stancek <jstancek@redhat.com>

