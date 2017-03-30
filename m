From: Alton L Pundt <apundt@us.ibm.com>
Date: Wed, 29 Mar 2017 21:06:07 -0600
Subject: [LTP] mc_cmds01 needs change from netstat command to ip maddr show
	dev
Message-ID: <OFEAC1E085.E5C67116-ON862580F3.00105817-862580F3.00110BF2@notes.na.collabserv.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I opened a redhat 7.3 bug when mc_cmds01 testcase was failing.   It seems 
that netstat only allows 10 characters for the interface.
Bug 147530 - ISST-LTE:pVM:tuliplp3 RHEL 7.3 RC 1 mc_cmds01 testcase 
failing 


[root@tuliplp3 faillogs]# vi mc_cmds.1476283713.22063
Getting ALL enabled interfaces which are configured !
Testing ifconfig and netstat
: doing ./mc_cmds01.
: doing ./mc_cmds01.
Test Failed: all-host-group for enP1p112s0f0 not joined
print $4}'
+ INTERFACE=10.33.22.161
+ COUNT=1
+ '[' 1 -le 20 ']'
+ echo 'Testing ifconfig and netstat'
+ ifconfig enP1p112s0f0
+ grep -q MULTICAST
+ '[' 0 '!=' 0 ']'
+ netstat -gn
+ grep -q 224.0.0.1
+ grep enP1p112s0f0
+ '[' 1 = 0 ']'
+ end_testcase 'all-host-group for enP1p112s0f0 not joined'
+ set -x
+ echo ': doing ./mc_cmds01.'
+ '[' ON = ON ']'
+ do_cleanup
+ set -x
+ echo ': doing ./mc_cmds01.'
+ rm -rf /tmp/mc_cmds_out.1476283713.22063
+ '[' 1 = 0 ']'
+ echo 'Test Failed: all-host-group for enP1p112s0f0 not joined'
+ exit 1

The developer showed this in the netstat.c program:
The problem, I believe is in netstat.c - in igmp_do_one()

    if (igmp6_flag) {    /* IPV6 */
#if HAVE_AFINET6
        num = sscanf( line, "%d %15s %64[0-9A-Fa-f] %d", &idx, device, 
mcast_addr, &refcnt );
        ...
        printf("%-15s %-6d %s\n", device, refcnt, mcast_addr)
    } else {    /* IPV4 */
         .... 
         if ((num = sscanf( line, "%d\t%10c", &idx, device)) < 2) {
                     OR
          if ( (num = sscanf( line, "%10c", device )) < 1 ) {
        ...
        printf("%-15s %-6d %s\n", device, refcnt, mcast_addr );
}

So in the IPv6 case the format width is 15 - so in our instances 
(tuliplp3/tuliplp4), the total width of the interface names fit in that 
and are printed fully.

However, for the IPv4 case, we see that the format specifier is limited to 
only 10 characters. In the case of tuliplp4, the interface names happen to 
be exactly 10 characters long (enp128s0f0, for example) and hence are 
printed properly.

But on tuliplp3, the interface names are longer than 10 characters. Hence 
it prints only 10 characters (enP1p112 four times instead of enP1p112f0, 
enP1p112f1, etc.)

and also showed that using netstat is obsolete:
This is actually covered in the netstat(8) man page:

===
NOTES
       This program is obsolete.  Replacement for netstat is ss. 
Replacement
       for  netstat -r is ip route.  Replacement for netstat -i is ip -s 
link.
       Replacement for netstat -g is ip maddr.
===

Have you tested with "ip maddr" instead?  For example, in your script,

  netstat -gn | grep $IFNAME | grep -q 224.0.0.1

would become:

  ip maddr show dev $IFNAME | grep -q 224.0.0.1

The extra benefit here is one less subshell and grep command to look for 
the target multicast group.

Thanks,
A.P. Pundt
sametime:apundt@us.ibm.com
office:512-286-8093
office: 45/3A-97
IBM-Austin, Texas

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170329/3d6e1d16/attachment.html>
