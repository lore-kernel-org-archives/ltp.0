From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 7 Feb 2020 09:56:10 -0500 (EST)
Subject: [LTP] [PATCH v2] Taunt OOM killer in fork12 setup()
In-Reply-To: <20200207145403.23193-1-mdoucha@suse.cz>
References: <1041474174.5093428.1580463462902.JavaMail.zimbra@redhat.com>
 <20200207145403.23193-1-mdoucha@suse.cz>
Message-ID: <1149510045.6536246.1581087370399.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> On a system with low memory, fork12 can trigger OOM killer before it hits
> any fork() limits. The OOM killer might accidentally kill e.g. the parent
> shell and external testing tools will assume the test failed.
> 
> Set high oom_score_adj on the children of the main fork12 process so that
> the OOM killer focuses on them.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>

Acked-by: Jan Stancek <jstancek@redhat.com>

