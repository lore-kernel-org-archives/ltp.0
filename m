From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 2 Jun 2017 08:48:05 -0400 (EDT)
Subject: [LTP] [PATCH v2] [RFC] pselect01: Tune thresholds
In-Reply-To: <833996051.19688092.1495532713977.JavaMail.zimbra@redhat.com>
References: <20170512141658.26810-1-chrubis@suse.cz>
 <1308561590.18511159.1495442352952.JavaMail.zimbra@redhat.com>
 <20170522131944.GC11771@rei.lan>
 <297220533.19197153.1495465050258.JavaMail.zimbra@redhat.com>
 <20170522151555.GD11771@rei.lan>
 <24535361.19636257.1495526084444.JavaMail.zimbra@redhat.com>
 <20170523091608.GA18460@rei.lan>
 <833996051.19688092.1495532713977.JavaMail.zimbra@redhat.com>
Message-ID: <1271292861.27850566.1496407685327.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> 
> > > > Can you try to rerun the test with a realtime priority?
> > > 
> > > Ran as "chrt -f 50 ./measure", results attached.
> > > 
> > 
> > Looks more or less the same and I still cannot reproduce the issue on
> > any of the machines I have here.
> > 
> > Looking at errata for AMD cpus #778 says that TSC may drift under some
> > circumstances:
> > http://support.amd.com/TechDocs/51810_16h_00h-0Fh_Rev_Guide.pdf#unique_29
> > 
> > Can you try to disable P-state in BIOS or set cpufreq to performance?

I've been running more numbers on different system. This one is pretty
beefy: IBM System x3950 X5 7145, 128 CPUs, 8 nodes. Kernel 4.11.3.

vendor_id	: GenuineIntel
cpu family	: 6
model		: 46
model name	: Intel(R) Xeon(R) CPU           X7560  @ 2.27GHz

With performance, default priority and MONOTONIC_RAW, it's getting very
closely to threshold, rarely failing pselect01 test.
My guess is it's because process gets migrated/woken up on
random CPUs. Attached is (pselect_timeout_1000.png) from your measure program.

Running it with FIFO scheduling shaves off ~50us on average.
What also helps is to pin it to CPU 0, that shaves off
another 70-80us.

Second image (pselect_timeout_1000_fifo_taskset.png) is same test,
but with "chrt -f 50 taskset -c 0 ...".

---

It also seems to slightly matter what CPU I pin it too,
CPU0 is always giving me better numbers:
(measuring just 1000us case)

# for i in `seq 0 4 127`; do echo -n "$i "; chrt -f 50 taskset -c $i ./measure; done
0 min 1016 max 1357 median 1114 mean 1113.19 0.1% 1.00
4 min 1014 max 1260 median 1181 mean 1171.47 0.1% 1.00
8 min 1014 max 1282 median 1192 mean 1189.95 0.1% 1.00
12 min 1011 max 1505 median 1195 mean 1186.83 0.1% 1.00
16 min 1022 max 1446 median 1191 mean 1189.87 0.1% 1.00
20 min 1013 max 1339 median 1195 mean 1190.65 0.1% 1.00
24 min 1016 max 1296 median 1160 mean 1160.90 0.1% 1.00
28 min 1015 max 1267 median 1167 mean 1170.56 0.1% 1.00
32 min 1035 max 1341 median 1194 mean 1191.09 0.1% 1.00
36 min 1013 max 1441 median 1194 mean 1187.54 0.1% 1.00
40 min 1014 max 1378 median 1194 mean 1187.12 0.1% 1.00
44 min 1014 max 1416 median 1195 mean 1194.01 0.1% 1.00
48 min 1016 max 1356 median 1194 mean 1185.55 0.1% 1.00
52 min 1014 max 1433 median 1195 mean 1192.50 0.1% 1.00
56 min 1021 max 1508 median 1195 mean 1192.92 0.1% 1.00
60 min 1014 max 1419 median 1195 mean 1193.41 0.1% 1.00
64 min 1013 max 1403 median 1121 mean 1118.02 0.1% 1.00
68 min 1014 max 1275 median 1180 mean 1165.64 0.1% 1.00
72 min 1020 max 1455 median 1189 mean 1190.73 0.1% 1.00
76 min 1016 max 1376 median 1195 mean 1189.82 0.1% 1.00
80 min 1017 max 1363 median 1192 mean 1191.22 0.1% 1.00
84 min 1013 max 1376 median 1194 mean 1188.59 0.1% 1.00
88 min 1016 max 1469 median 1194 mean 1191.31 0.1% 1.00
92 min 1013 max 1425 median 1195 mean 1192.05 0.1% 1.00
96 min 1016 max 1446 median 1195 mean 1190.17 0.1% 1.00
100 min 1017 max 1411 median 1195 mean 1191.20 0.1% 1.00
104 min 1017 max 1380 median 1194 mean 1193.50 0.1% 1.00
108 min 1016 max 1446 median 1195 mean 1194.53 0.1% 1.00
112 min 1016 max 1355 median 1194 mean 1190.82 0.1% 1.00
116 min 1018 max 1463 median 1194 mean 1190.94 0.1% 1.00
120 min 1089 max 1459 median 1195 mean 1195.75 0.1% 1.00
124 min 1017 max 1441 median 1195 mean 1195.05 0.1% 1.00

# numactl -H
available: 8 nodes (0-7)
node 0 cpus: 0 1 2 3 4 5 6 7 64 65 66 67 68 69 70 71
node 0 size: 7980 MB
node 0 free: 7827 MB
node 1 cpus: 8 9 10 11 12 13 14 15 72 73 74 75 76 77 78 79
node 1 size: 8061 MB
node 1 free: 7821 MB
node 2 cpus: 16 17 18 19 20 21 22 23 80 81 82 83 84 85 86 87
node 2 size: 8061 MB
node 2 free: 7934 MB
node 3 cpus: 24 25 26 27 28 29 30 31 88 89 90 91 92 93 94 95
node 3 size: 8046 MB
node 3 free: 7957 MB
node 4 cpus: 32 33 34 35 36 37 38 39 96 97 98 99 100 101 102 103
node 4 size: 8061 MB
node 4 free: 7932 MB
node 5 cpus: 40 41 42 43 44 45 46 47 104 105 106 107 108 109 110 111
node 5 size: 8061 MB
node 5 free: 7908 MB
node 6 cpus: 48 49 50 51 52 53 54 55 112 113 114 115 116 117 118 119
node 6 size: 8061 MB
node 6 free: 7969 MB
node 7 cpus: 56 57 58 59 60 61 62 63 120 121 122 123 124 125 126 127
node 7 size: 8060 MB
node 7 free: 7971 MB

Regards,
Jan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pselect_timeout_1000_fifo_taskset.png
Type: image/png
Size: 7900 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170602/ea6181f9/attachment-0002.png>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pselect_timeout_1000.png
Type: image/png
Size: 7857 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170602/ea6181f9/attachment-0003.png>
