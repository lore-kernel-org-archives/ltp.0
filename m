From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 20 Mar 2020 09:54:27 +0100
Subject: [LTP] [PATCH v4 3/3] Add connection tests for bind()
In-Reply-To: <20200317121057.13529-3-mdoucha@suse.cz>
References: <20200317121057.13529-1-mdoucha@suse.cz>
 <20200317121057.13529-3-mdoucha@suse.cz>
Message-ID: <20200320085427.GA14750@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

whole patchset is very nice work. Thanks!

> +static void setup(void)
> +{
> +	srand(time(0));
> +
> +	tst_init_sockaddr_inet(&ipv4_addr, IPV4_ADDRESS, 0);
> +	tst_init_sockaddr_inet_bin(&ipv4_any_addr, INADDR_ANY, 0);
> +	tst_init_sockaddr_inet6_bin(&ipv6_addr, &in6addr_loopback, 0);
> +	tst_init_sockaddr_inet6_bin(&ipv6_any_addr, &in6addr_any, 0);
> +}
You don't use tst_init_sockaddr_inet6() at all. How about using it?

Or do you have some reason not to use it?

Kind regards,
Petr

diff --git testcases/kernel/syscalls/bind/bind04.c testcases/kernel/syscalls/bind/bind04.c
index 1be14560b..cdd4f38f5 100644
--- testcases/kernel/syscalls/bind/bind04.c
+++ testcases/kernel/syscalls/bind/bind04.c
@@ -77,7 +77,7 @@ static void setup(void)
 
 	tst_init_sockaddr_inet(&ipv4_addr, IPV4_ADDRESS, 0);
 	tst_init_sockaddr_inet_bin(&ipv4_any_addr, INADDR_ANY, 0);
-	tst_init_sockaddr_inet6_bin(&ipv6_addr, &in6addr_loopback, 0);
+	tst_init_sockaddr_inet6(&ipv6_addr, IPV6_ADDRESS, 0);
 	tst_init_sockaddr_inet6_bin(&ipv6_any_addr, &in6addr_any, 0);
 }
 
diff --git testcases/kernel/syscalls/bind/bind05.c testcases/kernel/syscalls/bind/bind05.c
index 16c9c711d..fdab8b22e 100644
--- testcases/kernel/syscalls/bind/bind05.c
+++ testcases/kernel/syscalls/bind/bind05.c
@@ -77,7 +77,7 @@ static void setup(void)
 
 	tst_init_sockaddr_inet(&ipv4_addr, IPV4_ADDRESS, 0);
 	tst_init_sockaddr_inet_bin(&ipv4_any_addr, INADDR_ANY, 0);
-	tst_init_sockaddr_inet6_bin(&ipv6_addr, &in6addr_loopback, 0);
+	tst_init_sockaddr_inet6(&ipv6_addr, IPV6_ADDRESS, 0);
 	tst_init_sockaddr_inet6_bin(&ipv6_any_addr, &in6addr_any, 0);
 }
 
