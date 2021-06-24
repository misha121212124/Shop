package my.myclasses;

import java.awt.Color;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.lowagie.text.*;
import com.lowagie.text.pdf.*;


public class PDFExporter {
    private List<Cargo_count> cargoCountList;

    public PDFExporter(List<Cargo_count> cargoCountList) {
        this.cargoCountList = cargoCountList;
    }

    private void writeTableHeader(PdfPTable table) {
        PdfPCell cell = new PdfPCell();
        cell.setBackgroundColor(Color.BLUE);
        cell.setPadding(5);

//        Font font = FontFactory.getFont(FontFactory.COURIER);
//        font.setColor(Color.WHITE);

        BaseFont bf= null;
        try {
            bf = BaseFont.createFont("./src/main/webapp/resources/fonts/arial.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        } catch (IOException e) {
            e.printStackTrace();
        }
        Font font=new Font(bf,16,Font.NORMAL);
        font.setColor(Color.WHITE);


        cell.setPhrase(new Phrase("ID товару", font));

        table.addCell(cell);

        cell.setPhrase(new Phrase("Назва товару", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("Ціна", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("Кількість", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("Загальна ціна", font));
        table.addCell(cell);
    }

    private void writeTableData(PdfPTable table, Font font) {
        for (Cargo_count cargo_count : cargoCountList) {
            PdfPCell pdfPCell;

            Phrase ph = new Phrase(String.valueOf(cargo_count.cargo.getId()), font);
            pdfPCell = new PdfPCell(ph);
            table.addCell(ph);

            ph = new Phrase(String.valueOf(cargo_count.cargo.getName()), font);
            pdfPCell = new PdfPCell(ph);
            table.addCell(ph);

            ph = new Phrase(String.valueOf( cargo_count.cargo.getPrice()), font);
            pdfPCell = new PdfPCell(ph);
            table.addCell( ph );

            ph = new Phrase(String.valueOf(cargo_count.count), font);
            pdfPCell = new PdfPCell(ph);
            table.addCell( ph );

            ph = new Phrase(String.valueOf(cargo_count.count*cargo_count.cargo.getPrice()), font);
            pdfPCell = new PdfPCell(ph);
            table.addCell(ph);
        }
    }

    public void export(HttpServletResponse response) throws DocumentException, IOException {
        Document document = new Document(PageSize.A4);
        PdfWriter.getInstance(document, response.getOutputStream());

        document.open();
        BaseFont bf= null;
        try {
            bf = BaseFont.createFont("./src/main/webapp/resources/fonts/arial.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        } catch (IOException e) {
            e.printStackTrace();
        }
        Font font=new Font(bf,14,Font.BOLD);
//        font.setColor(Color.WHITE);
//        Font font = FontFactory.getFont(FontFactory.HELVETICA_BOLD);
//        font.setSize(18);
        font.setColor(Color.BLACK);

        Paragraph p = new Paragraph("Список проданих товарів", font);
        p.setAlignment(Paragraph.ALIGN_CENTER);

        document.add(p);

        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100f);
        table.setWidths(new float[] {1.1f, 3.5f, 1.0f, 1.4f, 1.5f});
        table.setSpacingBefore(10);

        writeTableHeader(table);
        writeTableData(table, font);

        document.add(table);

        document.close();

    }
}


