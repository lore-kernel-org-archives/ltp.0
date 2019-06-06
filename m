From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  6 Jun 2019 16:30:17 +0200
Subject: [LTP] [PATCH] shell: Fix tst_get_unused_port endianity
Message-ID: <20190606143017.2233-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_get_unused_port is a shell helper, therefore it should use host
byte order (we're not expecting this value would be added directly to
sockaddr_in structure, which require network byte order).
Wrap TST_GET_UNUSED_PORT() with ntohs() to achieve it.

Reported-by: Christian Amann <camann@suse.com>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I guess we didn't noticed this in shell script as sendfile01 is the only
one not requiring root (dns-stress, tst_net_stress.sh, ssh-stress, ssh-stress03-rmt do require it).

I tested patch with little script (could be easily converted to proper
test placed in lib/newlib_tests/)

export PATH="/opt/ltp/testcases/bin/:$PATH"
i=0
while [ $i -lt 2048 ]; do
    for j in ipv4 ipv6; do
        for k in stream dgram; do
            p="$(tst_get_unused_port $j $k)"
            printf "$i ($j $k): $p "
            if [ $p -lt 1024 ]; then
                echo "(bad)"
                exit 1
            else
                echo "(ok)"
            fi
        done
    done
    i=$((i+1))
done
echo "Test was ok"

 testcases/lib/tst_get_unused_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_get_unused_port.c b/testcases/lib/tst_get_unused_port.c
index 0173f1634..a843cc6e3 100644
--- a/testcases/lib/tst_get_unused_port.c
+++ b/testcases/lib/tst_get_unused_port.c
@@ -54,6 +54,6 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
-	printf("%d", TST_GET_UNUSED_PORT(family, type));
+	printf("%d", ntohs(TST_GET_UNUSED_PORT(family, type)));
 	return 0;
 }
-- 
2.21.0

