#!/usr/bin/perl
# Obrigado kodozin por me ajudar com a parte das regex ;p
# Mass Bin Checker by v4p0r
# Date 30/SET/2017
# Greetz: Yunkers Crew && BRLZ PoC && EOF Club && All Friends

use strict;
use WWW::Mechanize;
use Getopt::Long;

my $distro; 
my $usr = $^O;


if ( $usr eq "MSWin32") {
	system ("cls");
	system("title Mass Bin Checker");
} else {
	system ("clear");
	system("title Mass Bin Checker");
}

my $banner = @ARGV;

print "================================\n" .
	  "        Mass Bin Checker\n" .
	  "================================\n";
	  

my $optList;
my $optSave;
my $optHelp;
my $optBin;
my $oneBin;
my $Save;

	GetOptions('list|l=s'  => \$optList,
			   'bin|u=s'     => \$optBin,
			   'save|s=s'       => \$optSave,
			   'help|h'    => \$optHelp,
			  );

	if ($optHelp) { 
		print "\nUsage: $0 [comando]\n".
			  "[+] Comandos:\n".
			  "--bin  [Checa apenas 1 bin]\n".
			  "--help [Ajuda com os comandos]\n".
			  "--list [Seleciona sua lista de bin a ser checada]\n".
			  "--save [Onde as bins serao salvas]\n".
			  "       [Default: bin_list.txt]\n\n".
			  "[!] Exemplos:\n".
			  "perl $0 --list list.txt --save bins_check.txt\n".
			  "perl $0 --bin 553624\n";
		exit;
	}
	
	if ($optBin) {
		if ($optBin =~ /(\d{6})/g) {
			$oneBin = $optBin;
		} else {
			die "[!] Define a bin ae amigo, min 6 digitos\n";
		}
	}
	
	if ($optSave) {
		    $Save = $optSave;
		} else {
			$Save = "bin_list.txt";
		}
		
if ($oneBin) {

my $cardfull = $oneBin;

my ($card,$ignore) = split/;/,$cardfull;
my @bin1 = ($card =~ /(\d{6})/g);


my $mech = new WWW::Mechanize();
   $mech->get("https://www.cardbinlist.com/search.html?bin=".$bin1[0]."");
   
 
	my @get = $mech->content =~ /text.xs.left(.*)col.half.left/smi;
	my @get1 =  $get[0] =~ /<td><a href=".*">(.*?)<\/a><\/td>/;
	my @get2 = $get[0] =~ /<\/th>.*?<td>(.*?)<\/td>/gsm;
	my @get3 = $get2[5] =~ />(.*)</;

print "\nCHECK: " . $cardfull  . "\n" 
	  . "BIN: " . $bin1[0]  . "\n" 
	  . "PAIS: " . $get1[0] . "\n" 
	  . "CODE: " . $get2[1] . "\n" 
	  . "BAN: " . $get2[2] . "\n"
	  . "URL: " . $get2[3] . "\n"
	  . "TEL: " . $get2[4] . "\n"
	  . "BANDEIRA: " . $get3[0] . "\n"
	  . "TIPO: " . $get2[6] . "\n"
	  . "SUB: " . $get2[7] . "\n\n"
	  . "=============================================";	  
	  
	exit;
}

if($banner <= 1){

	print "\nCoder: v4p0r\n" .
	"Team: Yunkers Crew && BRLZ PoC\n" .
	"Twitter: 0x777null".
	"Skype: drx.priv\n\n" .
	"Usage: perl $0 --help\n";
	
	exit;
}

	open(my $list1,'<', $optList); 
	my @bin1 = <$list1>;
	
	print "\n[+] Lista a ser checada: ".$optList."\n";
	print "[+] Salvas em: ".$Save."\n";
	print "[+] ".scalar(@bin1)." Quantidade de bins a ser checkadas\n\n";
	
	
foreach my $bin2(@bin1) {

my $cardfull = $bin2;
   $cardfull =~ /(\d{6})/g;


my ($card,$ignore) = split/[;]/,$cardfull;
my @bin1 = ($card =~ /(\d{6})/g);


my $mech = new WWW::Mechanize();
   $mech->get("https://www.cardbinlist.com/search.html?bin=".$bin1[0]."");
 
	my @get = $mech->content =~ /text.xs.left(.*)col.half.left/smi;
	my @get1 =  $get[0] =~ /<td><a href=".*">(.*?)<\/a><\/td>/;
	my @get2 = $get[0] =~ /<\/th>.*?<td>(.*?)<\/td>/gsm;
	my @get3 = $get2[5] =~ />(.*)</;

print "\n";
print "CARD: ".$cardfull.""
	  ."BIN: ".$bin1[0]." | "
	  ."PAIS: " . $get1[0] . " | "
	  ."CODE: " . $get2[1] . " | "
	  ."BAN: " . $get2[2] . " | "
	  ."URL: " . $get2[3] . " | "
	  ."TEL: " . $get2[4] . " | "
	  ."BANDEIRA: " . $get3[0] . " | "
	  ."TIPO: " . $get2[6] . " | "
	  ."SUB: " . $get2[7] . "\n"
	  . "=============================================";
	  
	  	open(my $fh, '>>', $Save);
		print $fh "CARD: ".$cardfull.""."BIN: ".$bin1[0]." | "."PAIS: " . $get1[0] . " | "."CODE: " . $get2[1] . " | "."BAN: " . $get2[2] . " | "."URL: " . $get2[3] . " | "."TEL: " . $get2[4] . " | "."BANDEIRA: " . $get3[0] . " | "."TIPO: " . $get2[6] . " | "."SUB: " . $get2[7] . "\n";
		close $fh;	
}

__END__