From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Apr 2020 12:41:29 +0200
Subject: [LTP] [PATCH v5 2/2] net/route: Add netlink based route change
 tests
In-Reply-To: <8b3ae56d-1c28-e43b-abea-963a32fff8f6@oracle.com>
References: <20200423131632.20525-1-pvorel@suse.cz>
 <20200423131632.20525-3-pvorel@suse.cz>
 <8b3ae56d-1c28-e43b-abea-963a32fff8f6@oracle.com>
Message-ID: <20200429104129.GA685@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Minor comments below.
Thanks for your review!

> > +	for (i = 0; i < num_loops; i++) {
> > +		if (iface_len > 1)
> > +			tst_res(TINFO, "testing gw: %s, iface: %s",
> > +					p_gw->ip_str, p_iface->iface);
> > +		else if (gw_len > 1)
> > +			tst_res(TINFO, "testing gw: %s", p_gw->ip_str);
> > +		else
> > +			tst_res(TINFO, "testing dst: %s/%d", p_dst->ip_str, prefix);


> It would be better to avoid printing it on every iteration, especially
> with the large NS_TIMES.
Understand, I thought you wouldn't like it. How about print only on error?

> > +
> > +		rtnl_route(p_iface->index, p_dst->ip, gw ? p_gw->ip : NULL,
> > +			   prefix, RTM_NEWROUTE);
> > +		send_udp(p_rhost->ip);
> > +		rtnl_route(p_iface->index, p_dst->ip, gw ? p_gw->ip : NULL,
> > +			   prefix, RTM_DELROUTE);
> > +
> > +		if (gw)
> > +			p_gw = p_gw->next ?: gw;
> > +		p_dst = p_dst->next ?: dst;
> > +		p_iface = p_iface->next ?: iface;
> > +		p_rhost = p_rhost->next ?: rhost;
> > +	}
> > +
> > +	tst_res(TPASS, "routes created and deleted");
> > +}

Something like this?

static void print_route_info(int iface, struct sockaddr *dst,
			     struct sockaddr *gw, int type)
{
	char dst_str[INET6_ADDRSTRLEN], gw_str[INET6_ADDRSTRLEN];
	tst_sock_addr(dst, sizeof(dst), dst_str, sizeof(dst_str));
	if (gw)
		tst_sock_addr(gw, sizeof(gw), gw_str, sizeof(gw_str));

	tst_res(TINFO, "type: %s, iface: %d, dst: %s, gw: %s",
		type == RTM_NEWROUTE ? "RTM_NEWROUTE" : "RTM_DELROUTE",
		iface, dst_str, gw ? gw_str : "null");
	tst_brk(TBROK, "failed due previous netlink errors");
}

static void rtnl_route(int iface, struct addrinfo *dst, struct addrinfo *gw,
		       int type)
{
	struct mnl_socket *nl;
	char buf[MNL_SOCKET_BUFFER_SIZE];
	struct nlmsghdr *nlh;
	struct rtmsg *rtm;
	uint32_t seq, portid;
	struct in6_addr dst_in6, gw_in6;
	in_addr_t dst_ip, gw_ip;
	int ret;

	nlh = mnl_nlmsg_put_header(buf);
	nlh->nlmsg_type	= type;

	nlh->nlmsg_flags = NLM_F_ACK;
	if (type == RTM_NEWROUTE)
		nlh->nlmsg_flags |= NLM_F_REQUEST | NLM_F_CREATE | NLM_F_REPLACE;

	nlh->nlmsg_seq = seq = time(NULL);

	rtm = mnl_nlmsg_put_extra_header(nlh, sizeof(struct rtmsg));
	rtm->rtm_family = family;
	rtm->rtm_dst_len = prefix;
	rtm->rtm_src_len = 0;
	rtm->rtm_tos = 0;
	rtm->rtm_protocol = RTPROT_STATIC;
	rtm->rtm_table = RT_TABLE_MAIN;
	rtm->rtm_type = RTN_UNICAST;
	rtm->rtm_scope = gw ? RT_SCOPE_UNIVERSE : RT_SCOPE_LINK;
	rtm->rtm_flags = 0;

	if (is_ipv6) {
		dst_in6 = ((struct sockaddr_in6 *)dst->ai_addr)->sin6_addr;
		mnl_attr_put(nlh, RTA_DST, sizeof(struct in6_addr), &dst_in6);
	} else {
		dst_ip = ((struct sockaddr_in *)dst->ai_addr)->sin_addr.s_addr;
		mnl_attr_put_u32(nlh, RTA_DST, dst_ip);
	}

	mnl_attr_put_u32(nlh, RTA_OIF, iface);

	if (gw) {
		if (is_ipv6) {
			gw_in6 = ((struct sockaddr_in6 *)gw->ai_addr)->sin6_addr;
			mnl_attr_put(nlh, RTA_GATEWAY, sizeof(struct in6_addr), &gw_in6);
		} else {
			gw_ip = ((struct sockaddr_in *)gw->ai_addr)->sin_addr.s_addr;
			mnl_attr_put_u32(nlh, RTA_GATEWAY, gw_ip);
		}
	}

	nl = mnl_socket_open(NETLINK_ROUTE);
	if (nl == NULL) {
		tst_res(TFAIL, "mnl_socket_open failed (errno=%d): %s", errno,
			strerror(errno));
		goto err;
	}

	if (mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID) < 0) {
		tst_res(TFAIL, "mnl_socket_bind failed (errno=%d): %s", errno,
			strerror(errno));
		goto err;
	}

	portid = mnl_socket_get_portid(nl);

	if (mnl_socket_sendto(nl, nlh, nlh->nlmsg_len) < 0) {
		tst_res(TFAIL, "mnl_socket_sendto failed (errno=%d): %s", errno,
			strerror(errno));
		goto err;
	}

	ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
	if (ret < 0) {
		tst_res(TFAIL, "mnl_socket_recvfrom failed (ret=%d, errno=%d): %s",
			ret, errno, strerror(errno));
		goto err;
	}

	ret = mnl_cb_run(buf, ret, seq, portid, NULL, NULL);
	if (ret < 0) {
		tst_res(TFAIL, "mnl_cb_run failed (ret=%d, errno=%d): %s", ret,
			errno, strerror(errno));
		goto err;
	}

	mnl_socket_close(nl);
	return;
err:
	print_route_info(iface, dst->ai_addr, gw ? gw->ai_addr: NULL, type);
}


> > +
> > +static struct tst_option options[] = {
> > +	{"6", &ipv6_opt, "-6       Use IPv6 (default is IPv4)"},
> > +	{"c:", &c_opt, "         Num loops (mandatory)"},

> "-c x ...
Fixed.


BTW I also removed prefix parameter from rtnl_route() (it's a global parameter,
family is not passed either).

https://github.com/pevik/ltp/blob/route/c.v5.fixes/testcases/network/stress/route/route-change-netlink.c
+ below is full diff against posted version.

Kind regards,
Petr

diff --git testcases/network/stress/route/route-change-netlink.c testcases/network/stress/route/route-change-netlink.c
index 57ae02a3c..80677f1a4 100644
--- testcases/network/stress/route/route-change-netlink.c
+++ testcases/network/stress/route/route-change-netlink.c
@@ -177,7 +177,22 @@ static void cleanup(void)
 		mnl_socket_close(nl);
 }
 
-static void rtnl_route(int iface, struct addrinfo *dst, struct addrinfo *gw, uint32_t prefix, int type)
+static void print_route_info(int iface, struct sockaddr *dst,
+			     struct sockaddr *gw, int type)
+{
+	char dst_str[INET6_ADDRSTRLEN], gw_str[INET6_ADDRSTRLEN];
+	tst_sock_addr(dst, sizeof(dst), dst_str, sizeof(dst_str));
+	if (gw)
+		tst_sock_addr(gw, sizeof(gw), gw_str, sizeof(gw_str));
+
+	tst_res(TINFO, "type: %s, iface: %d, dst: %s, gw: %s",
+		type == RTM_NEWROUTE ? "RTM_NEWROUTE" : "RTM_DELROUTE",
+		iface, dst_str, gw ? gw_str : "null");
+	tst_brk(TBROK, "failed due previous netlink errors");
+}
+
+static void rtnl_route(int iface, struct addrinfo *dst, struct addrinfo *gw,
+		       int type)
 {
 	struct mnl_socket *nl;
 	char buf[MNL_SOCKET_BUFFER_SIZE];
@@ -229,31 +244,44 @@ static void rtnl_route(int iface, struct addrinfo *dst, struct addrinfo *gw, uin
 	}
 
 	nl = mnl_socket_open(NETLINK_ROUTE);
-	if (nl == NULL)
-		tst_brk(TBROK, "mnl_socket_open failed (errno=%d): %s", errno,
+	if (nl == NULL) {
+		tst_res(TFAIL, "mnl_socket_open failed (errno=%d): %s", errno,
 			strerror(errno));
+		goto err;
+	}
 
-	if (mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID) < 0)
-		tst_brk(TBROK, "mnl_socket_bind failed (errno=%d): %s", errno,
+	if (mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID) < 0) {
+		tst_res(TFAIL, "mnl_socket_bind failed (errno=%d): %s", errno,
 			strerror(errno));
+		goto err;
+	}
 
 	portid = mnl_socket_get_portid(nl);
 
-	if (mnl_socket_sendto(nl, nlh, nlh->nlmsg_len) < 0)
-		tst_brk(TBROK, "mnl_socket_sendto failed (errno=%d): %s", errno,
+	if (mnl_socket_sendto(nl, nlh, nlh->nlmsg_len) < 0) {
+		tst_res(TFAIL, "mnl_socket_sendto failed (errno=%d): %s", errno,
 			strerror(errno));
+		goto err;
+	}
 
 	ret = mnl_socket_recvfrom(nl, buf, sizeof(buf));
-	if (ret < 0)
-		tst_brk(TBROK, "mnl_socket_recvfrom failed (ret=%d, errno=%d): %s",
+	if (ret < 0) {
+		tst_res(TFAIL, "mnl_socket_recvfrom failed (ret=%d, errno=%d): %s",
 			ret, errno, strerror(errno));
+		goto err;
+	}
 
 	ret = mnl_cb_run(buf, ret, seq, portid, NULL, NULL);
-	if (ret < 0)
-		tst_brk(TBROK, "mnl_cb_run failed (ret=%d, errno=%d): %s", ret,
+	if (ret < 0) {
+		tst_res(TFAIL, "mnl_cb_run failed (ret=%d, errno=%d): %s", ret,
 			errno, strerror(errno));
+		goto err;
+	}
 
 	mnl_socket_close(nl);
+	return;
+err:
+	print_route_info(iface, dst->ai_addr, gw ? gw->ai_addr: NULL, type);
 }
 
 static void send_udp(struct addrinfo *rhost_addrinfo)
@@ -274,19 +302,11 @@ static void run(void)
 	struct iface *p_iface = iface;
 
 	for (i = 0; i < num_loops; i++) {
-		if (iface_len > 1)
-			tst_res(TINFO, "testing gw: %s, iface: %s",
-					p_gw->ip_str, p_iface->iface);
-		else if (gw_len > 1)
-			tst_res(TINFO, "testing gw: %s", p_gw->ip_str);
-		else
-			tst_res(TINFO, "testing dst: %s/%d", p_dst->ip_str, prefix);
-
 		rtnl_route(p_iface->index, p_dst->ip, gw ? p_gw->ip : NULL,
-			   prefix, RTM_NEWROUTE);
+			   RTM_NEWROUTE);
 		send_udp(p_rhost->ip);
 		rtnl_route(p_iface->index, p_dst->ip, gw ? p_gw->ip : NULL,
-			   prefix, RTM_DELROUTE);
+			   RTM_DELROUTE);
 
 		if (gw)
 			p_gw = p_gw->next ?: gw;
@@ -300,7 +320,7 @@ static void run(void)
 
 static struct tst_option options[] = {
 	{"6", &ipv6_opt, "-6       Use IPv6 (default is IPv4)"},
-	{"c:", &c_opt, "         Num loops (mandatory)"},
+	{"c:", &c_opt, "-c x     Num loops (mandatory)"},
 	{"d:", &d_opt, "-d iface Interface to work on (mandatory)"},
 	{"g:", &g_opt, "-g x     Gateway IP"},
 	{"p:", &p_opt, "-p port  Rhost port (mandatory)"},
